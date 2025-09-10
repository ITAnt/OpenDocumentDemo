package at.tomtasche.reader.background;

import android.content.Context;
import android.net.Uri;
import android.os.Handler;
import android.util.Log;
import android.webkit.MimeTypeMap;

import java.io.File;

import at.tomtasche.reader.nonfree.AnalyticsManager;
import at.tomtasche.reader.nonfree.ConfigManager;
import at.tomtasche.reader.nonfree.CrashManager;

public class CoreLoader extends FileLoader {

    private final ConfigManager configManager;

    private CoreWrapper.CoreOptions lastCoreOptions;

    private final boolean doOoxml;
    private final boolean doHttp;

    private Thread httpThread;

    public CoreLoader(Context context, ConfigManager configManager, boolean doOoxml, boolean doHttp) {
        super(context, LoaderType.CORE);

        this.configManager = configManager;
        this.doOoxml = doOoxml;
        this.doHttp = doHttp;

        System.out.println("CoreLoader: Initializing with doHttp=" + doHttp + ", doOoxml=" + doOoxml);
        
        try {
            CoreWrapper.initialize(context);
            System.out.println("CoreLoader: CoreWrapper.initialize() completed successfully");
        } catch (Exception e) {
            System.err.println("CoreLoader: CoreWrapper.initialize() failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void initialize(FileLoaderListener listener, Handler mainHandler, Handler backgroundHandler, AnalyticsManager analyticsManager, CrashManager crashManager) {
        if (doHttp) {
            System.out.println("CoreLoader: Initializing HTTP server mode");
            File serverCacheDir = new File(context.getCacheDir(), "core/server");
            System.out.println("CoreLoader: Server cache directory: " + serverCacheDir.getAbsolutePath());
            
            if (!serverCacheDir.isDirectory() && !serverCacheDir.mkdirs()) {
                Log.e("CoreLoader", "Failed to create cache directory for CoreWrapper server: " + serverCacheDir.getAbsolutePath());
                System.err.println("CoreLoader: Failed to create server cache directory");
            } else {
                System.out.println("CoreLoader: Server cache directory created successfully");
            }
            
            try {
                CoreWrapper.createServer(serverCacheDir.getAbsolutePath());
                System.out.println("CoreLoader: createServer completed successfully");
            } catch (UnsatisfiedLinkError e) {
                System.err.println("CoreLoader: Native library not available for createServer: " + e.getMessage());
                crashManager.log(e);
                return; // 不启动HTTP线程
            } catch (Exception e) {
                System.err.println("CoreLoader: createServer failed: " + e.getMessage());
                crashManager.log(e);
                return; // 不启动HTTP线程
            }

            httpThread = new Thread(() -> {
                try {
                    System.out.println("CoreLoader: Starting HTTP server on port 29665");
                    CoreWrapper.listenServer(29665);
                    System.out.println("CoreLoader: HTTP server started successfully");
                } catch (Throwable e) {
                    System.err.println("CoreLoader: HTTP server failed to start: " + e.getMessage());
                    e.printStackTrace();
                    crashManager.log(e);
                }
            });
            httpThread.start();
            System.out.println("CoreLoader: HTTP server thread started");
        }

        super.initialize(listener, mainHandler, backgroundHandler, analyticsManager, crashManager);
    }

    @Override
    public boolean isSupported(Options options) {
        return options.fileType.startsWith("application/vnd.oasis.opendocument") ||
                options.fileType.startsWith("application/x-vnd.oasis.opendocument") ||
                options.fileType.startsWith("application/vnd.oasis.opendocument.text-master") ||
                (this.doOoxml && (
                        options.fileType.startsWith("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
                        // TODO: enable xlsx and pptx too
                        //options.fileType.startsWith("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") ||
                        //options.fileType.startsWith("application/vnd.openxmlformats-officedocument.spreadsheetml.presentation");
                ));
    }

    @Override
    public void loadSync(Options options) {
        final Result result = new Result();
        result.options = options;
        result.loaderType = type;

        try {
            translate(options, result);

            callOnSuccess(result);
        } catch (Throwable e) {
            if (e instanceof CoreWrapper.CoreEncryptedException) {
                e = new EncryptedDocumentException();
            }

            callOnError(result, e);
        }
    }

    private void translate(Options options, Result result) throws Exception {
        File cachedFile = AndroidFileCache.getCacheFile(context, options.cacheUri);

        File cacheDirectory = AndroidFileCache.getCacheDirectory(cachedFile);

        File coreOutputDirectory = new File(cacheDirectory, "core_output");
        File coreCacheDirectory = new File(cacheDirectory, "core_cache");

        CoreWrapper.CoreOptions coreOptions = new CoreWrapper.CoreOptions();
        coreOptions.inputPath = cachedFile.getPath();
        coreOptions.outputPath = coreOutputDirectory.getPath();
        coreOptions.cachePath = coreCacheDirectory.getPath();
        coreOptions.password = options.password;
        coreOptions.editable = options.translatable;
        coreOptions.ooxml = doOoxml;
        coreOptions.txt = false;
        coreOptions.pdf = false;

        Boolean usePaging = configManager.getBooleanConfig("use_paging");
        if (usePaging == null || usePaging) {
            coreOptions.paging = true;
        }

        lastCoreOptions = coreOptions;

        if (doHttp) {
            System.out.println("CoreLoader: Using HTTP mode, calling hostFile");
            CoreWrapper.CoreResult coreResult = CoreWrapper.hostFile("odr", coreOptions);

            if (coreResult.exception != null) {
                System.err.println("CoreLoader: hostFile failed with exception: " + coreResult.exception.getClass().getSimpleName());
                throw coreResult.exception;
            }

            System.out.println("CoreLoader: hostFile generated " + coreResult.pagePaths.size() + " pages");
            for (int i = 0; i < coreResult.pagePaths.size(); i++) {
                String pagePath = coreResult.pagePaths.get(i);
                System.out.println("CoreLoader: Page " + i + " URL: " + pagePath);
                result.partTitles.add(coreResult.pageNames.get(i));
                result.partUris.add(Uri.parse(pagePath));
            }
        } else {
            System.out.println("CoreLoader: Using file mode, calling parse");
            CoreWrapper.CoreResult coreResult = CoreWrapper.parse(coreOptions);

            String coreExtension = coreResult.extension;
            if (coreResult.exception == null && "pdf".equals(coreExtension)) {
                // some PDFs do not cause an error in the core
                // https://github.com/opendocument-app/OpenDocument.droid/issues/348#issuecomment-2446888981
                throw new CoreWrapper.CoreCouldNotTranslateException();
            } else if (!"unnamed".equals(coreExtension)) {
                // "unnamed" refers to default of Meta::typeToString
                options.fileExtension = coreExtension;

                String fileType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(coreExtension);
                if (fileType != null) {
                    options.fileType = fileType;
                }
            }

            if (coreResult.exception != null) {
                System.err.println("CoreLoader: parse failed with exception: " + coreResult.exception.getClass().getSimpleName());
                throw coreResult.exception;
            }

            System.out.println("CoreLoader: parse generated " + coreResult.pagePaths.size() + " pages");
            for (int i = 0; i < coreResult.pagePaths.size(); i++) {
                File entryFile = new File(coreResult.pagePaths.get(i));
                System.out.println("CoreLoader: Page " + i + " file: " + entryFile.getAbsolutePath());
                System.out.println("CoreLoader: File exists: " + entryFile.exists());
                
                result.partTitles.add(coreResult.pageNames.get(i));
                result.partUris.add(Uri.fromFile(entryFile));
            }
        }
    }

    @Override
    public File retranslate(Options options, String htmlDiff) {
        if (lastCoreOptions == null) {
            // necessary if fragment was destroyed in the meanwhile - meaning the Loader is reinstantiated

            Result result = new Result();
            result.options = options;

            try {
                translate(options, result);
            } catch (Exception e) {
                crashManager.log(e);

                return null;
            }
        }

        File inputFile = new File(lastCoreOptions.inputPath);
        File inputCacheDirectory = AndroidFileCache.getCacheDirectory(inputFile);
        File tempFilePrefix = new File(inputCacheDirectory, "retranslate");

        lastCoreOptions.outputPath = tempFilePrefix.getPath();

        try {
            CoreWrapper.CoreResult result = CoreWrapper.backtranslate(lastCoreOptions, htmlDiff);

            return new File(result.outputPath);
        } catch (Throwable e) {
            crashManager.log(e);

            return null;
        }
    }

    @Override
    public void close() {
        super.close();

        if (httpThread != null) {
            CoreWrapper.stopServer();
            try {
                httpThread.join(1000);
            } catch (InterruptedException e) {
                crashManager.log(e);
            }
            httpThread = null;
        }

        CoreWrapper.close();
    }
}
