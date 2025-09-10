package at.tomtasche.reader.background;

import android.content.Context;

// 移除 AssetExtractor 依赖，使用原生 Android API

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

public class CoreWrapper {
    static {
        try {
            System.loadLibrary("odr-core");
            System.out.println("CoreWrapper: Native library 'odr-core' loaded successfully");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("CoreWrapper: Failed to load native library 'odr-core': " + e.getMessage());
            throw e;
        }
    }

    public static class GlobalParams {
        public String coreDataPath;
        public String fontconfigDataPath;
        public String popplerDataPath;
        public String pdf2htmlexDataPath;
        public String customTmpfilePath;
    }

    public static native void setGlobalParams(GlobalParams params);

    private static void extractAssets(Context context, File targetDir, String assetPath) {
        try {
            System.out.println("CoreWrapper: Extracting asset path: " + assetPath);
            String[] files = context.getAssets().list(assetPath);
            System.out.println("CoreWrapper: Found " + (files != null ? files.length : 0) + " items in " + assetPath);
            
            if (files == null || files.length == 0) {
                // 这可能是一个文件，或者路径不存在
                try {
                    // 尝试作为文件打开
                    context.getAssets().open(assetPath).close();
                    // 如果成功，说明这是一个文件
                    File targetFile = new File(targetDir, new File(assetPath).getName());
                    System.out.println("CoreWrapper: Copying file " + assetPath + " to " + targetFile.getAbsolutePath());
                    copyAssetFile(context, assetPath, targetFile);
                } catch (IOException fileException) {
                    // 既不是目录也不是文件，路径不存在
                    System.err.println("CoreWrapper: Asset path does not exist: " + assetPath);
                    System.err.println("CoreWrapper: This is likely why odr object is not available in AAR environment");
                }
            } else {
                // 这是一个目录
                File dir = new File(targetDir, new File(assetPath).getName());
                if (!dir.exists()) {
                    boolean created = dir.mkdirs();
                    System.out.println("CoreWrapper: Created directory " + dir.getAbsolutePath() + ": " + created);
                }
                for (String file : files) {
                    System.out.println("CoreWrapper: Processing sub-item: " + file);
                    extractAssets(context, dir, assetPath + "/" + file);
                }
            }
        } catch (IOException e) {
            System.err.println("CoreWrapper: Error extracting assets from " + assetPath + ": " + e.getMessage());
            System.err.println("CoreWrapper: This indicates assets are not properly packaged in AAR");
            e.printStackTrace();
        }
    }

    private static void copyAssetFile(Context context, String assetPath, File targetFile) {
        try {
            targetFile.getParentFile().mkdirs();
            InputStream in = context.getAssets().open(assetPath);
            FileOutputStream out = new FileOutputStream(targetFile);
            
            byte[] buffer = new byte[1024];
            int read;
            long totalBytes = 0;
            while ((read = in.read(buffer)) != -1) {
                out.write(buffer, 0, read);
                totalBytes += read;
            }
            
            in.close();
            out.close();
            
            System.out.println("CoreWrapper: Successfully copied " + assetPath + " (" + totalBytes + " bytes) to " + targetFile.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("CoreWrapper: Error copying asset file " + assetPath + ": " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void initialize(Context context) {
        System.out.println("CoreWrapper: Starting initialization");
        System.out.println("CoreWrapper: Context class: " + context.getClass().getName());
        System.out.println("CoreWrapper: Package name: " + context.getPackageName());
        
        // 首先检查assets是否可访问
        try {
            String[] rootAssets = context.getAssets().list("");
            System.out.println("CoreWrapper: Root assets available: " + java.util.Arrays.toString(rootAssets));
            
            // 检查core目录是否存在
            String[] coreAssets = context.getAssets().list("core");
            System.out.println("CoreWrapper: Core assets available: " + java.util.Arrays.toString(coreAssets));
            
            if (coreAssets != null && coreAssets.length > 0) {
                for (String asset : coreAssets) {
                    System.out.println("CoreWrapper: Found core asset: " + asset);
                    try {
                        String[] subAssets = context.getAssets().list("core/" + asset);
                        System.out.println("CoreWrapper: " + asset + " contains: " + java.util.Arrays.toString(subAssets));
                        
                        // 特别检查odrcore目录
                        if ("odrcore".equals(asset)) {
                            for (String odrFile : subAssets) {
                                System.out.println("CoreWrapper: ODR file found: " + odrFile);
                                try {
                                    java.io.InputStream is = context.getAssets().open("core/odrcore/" + odrFile);
                                    int size = is.available();
                                    is.close();
                                    System.out.println("CoreWrapper: " + odrFile + " size: " + size + " bytes");
                                } catch (Exception fileEx) {
                                    System.err.println("CoreWrapper: Cannot access " + odrFile + ": " + fileEx.getMessage());
                                }
                            }
                        }
                    } catch (Exception e) {
                        System.out.println("CoreWrapper: " + asset + " is a file, not directory");
                    }
                }
            } else {
                System.err.println("CoreWrapper: No core assets found! This is the root cause of the problem.");
                // 尝试查找odr相关的assets
                for (String asset : rootAssets) {
                    if (asset.toLowerCase().contains("odr") || asset.toLowerCase().contains("core")) {
                        System.out.println("CoreWrapper: Found potential asset: " + asset);
                    }
                }
                
                // 尝试直接访问odr.js文件
                try {
                    java.io.InputStream odrJs = context.getAssets().open("core/odrcore/odr.js");
                    System.out.println("CoreWrapper: Direct access to odr.js successful, size: " + odrJs.available());
                    odrJs.close();
                } catch (Exception directEx) {
                    System.err.println("CoreWrapper: Direct access to odr.js failed: " + directEx.getMessage());
                }
            }
        } catch (Exception e) {
            System.err.println("CoreWrapper: Failed to list assets: " + e.getMessage());
            e.printStackTrace();
        }
        
        File assetsDirectory = new File(context.getFilesDir(), "assets");
        File odrCoreDataDirectory = new File(assetsDirectory, "odrcore");
        File fontconfigDataDirectory = new File(assetsDirectory, "fontconfig");
        File popplerDataDirectory = new File(assetsDirectory, "poppler");
        File pdf2htmlexDataDirectory = new File(assetsDirectory, "pdf2htmlex");

        System.out.println("CoreWrapper: Assets directory: " + assetsDirectory.getAbsolutePath());
        System.out.println("CoreWrapper: ODR core directory: " + odrCoreDataDirectory.getAbsolutePath());

        // 使用原生 Android API 提取 assets
        System.out.println("CoreWrapper: Extracting odrcore assets");
        extractAssets(context, assetsDirectory, "core/odrcore");
        System.out.println("CoreWrapper: ODR core assets extracted, directory exists: " + odrCoreDataDirectory.exists());
        
        // 检查提取后的文件
        if (odrCoreDataDirectory.exists()) {
            File[] files = odrCoreDataDirectory.listFiles();
            System.out.println("CoreWrapper: ODR core directory contains " + (files != null ? files.length : 0) + " files");
            if (files != null) {
                for (File file : files) {
                    System.out.println("CoreWrapper: - " + file.getName() + " (" + file.length() + " bytes)");
                }
                
                // 特别检查关键的odr.js文件
                File odrJsFile = new File(odrCoreDataDirectory, "odr.js");
                if (odrJsFile.exists()) {
                    System.out.println("CoreWrapper: ✓ odr.js found (" + odrJsFile.length() + " bytes) - odr object should be available");
                } else {
                    System.err.println("CoreWrapper: ✗ odr.js NOT found - this explains why odr object is missing in AAR environment");
                }
                
                File odrSpreadsheetJsFile = new File(odrCoreDataDirectory, "odr_spreadsheet.js");
                if (odrSpreadsheetJsFile.exists()) {
                    System.out.println("CoreWrapper: ✓ odr_spreadsheet.js found (" + odrSpreadsheetJsFile.length() + " bytes)");
                } else {
                    System.err.println("CoreWrapper: ✗ odr_spreadsheet.js NOT found");
                }
            }
        } else {
            System.err.println("CoreWrapper: ✗ ODR core directory does not exist - assets extraction failed completely");
        }
        
        System.out.println("CoreWrapper: Extracting fontconfig assets");
        extractAssets(context, assetsDirectory, "core/fontconfig");
        System.out.println("CoreWrapper: Extracting poppler assets");
        extractAssets(context, assetsDirectory, "core/poppler");
        System.out.println("CoreWrapper: Extracting pdf2htmlex assets");
        extractAssets(context, assetsDirectory, "core/pdf2htmlex");

        CoreWrapper.GlobalParams globalParams = new CoreWrapper.GlobalParams();
        globalParams.coreDataPath = odrCoreDataDirectory.getAbsolutePath();
        globalParams.fontconfigDataPath = fontconfigDataDirectory.getAbsolutePath();
        globalParams.popplerDataPath = popplerDataDirectory.getAbsolutePath();
        globalParams.pdf2htmlexDataPath = pdf2htmlexDataDirectory.getAbsolutePath();
        globalParams.customTmpfilePath = context.getCacheDir().getAbsolutePath();
        
        System.out.println("CoreWrapper: Setting global params");
        System.out.println("CoreWrapper: coreDataPath = " + globalParams.coreDataPath);
        System.out.println("CoreWrapper: customTmpfilePath = " + globalParams.customTmpfilePath);
        
        try {
            CoreWrapper.setGlobalParams(globalParams);
            System.out.println("CoreWrapper: setGlobalParams completed successfully");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("CoreWrapper: Native library not available for setGlobalParams: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.err.println("CoreWrapper: setGlobalParams failed: " + e.getMessage());
            throw e;
        }
    }

    public static class CoreOptions {
        public boolean ooxml;
        public boolean txt;
        public boolean pdf;

        public boolean editable;

        public boolean paging;

        public String password;

        public String inputPath;
        public String outputPath;
        public String cachePath;
    }

    public static CoreResult parse(CoreOptions options) {
        System.out.println("CoreWrapper: Starting parse for " + options.inputPath);
        
        CoreResult result;
        try {
            result = parseNative(options);
            System.out.println("CoreWrapper: parseNative completed with errorCode: " + result.errorCode);
            
            // 检查结果是否有效
            if (result.pagePaths != null && !result.pagePaths.isEmpty()) {
                System.out.println("CoreWrapper: Generated " + result.pagePaths.size() + " pages");
            } else {
                System.out.println("CoreWrapper: No pages generated - this may cause odr object to be missing");
            }
        } catch (UnsatisfiedLinkError e) {
            System.err.println("CoreWrapper: Native library not available: " + e.getMessage());
            result = new CoreResult();
            result.errorCode = -4; // CoreCouldNotTranslateException
            return result;
        } catch (Exception e) {
            System.err.println("CoreWrapper: parseNative failed: " + e.getMessage());
            e.printStackTrace();
            result = new CoreResult();
            result.errorCode = -3; // CoreUnknownErrorException
            return result;
        }

        switch (result.errorCode) {
            case 0:
                break;
            case -1:
                result.exception = new CoreCouldNotOpenException();
                break;
            case -2:
                result.exception = new CoreEncryptedException();
                break;
            case -3:
                result.exception = new CoreUnknownErrorException();
                break;
            case -4:
                result.exception = new CoreCouldNotTranslateException();
                break;
            case -5:
                result.exception = new CoreUnexpectedFormatException();
                break;
            default:
                result.exception = new CoreUnexpectedErrorCodeException();
                break;
        }

        return result;
    }

    private static native CoreResult parseNative(CoreOptions options);

    public static CoreResult backtranslate(CoreOptions options, String htmlDiff) {
        CoreResult result = backtranslateNative(options, htmlDiff);

        switch (result.errorCode) {
            case 0:
                break;
            case -3:
                result.exception = new CoreUnknownErrorException();
                break;
            case -6:
                result.exception = new CoreCouldNotEditException();
                break;
            case -7:
                result.exception = new CoreCouldNotSaveException();
                break;
            default:
                result.exception = new CoreUnexpectedErrorCodeException();
                break;
        }

        return result;
    }

    private static native CoreResult backtranslateNative(CoreOptions options, String htmlDiff);

    public static void close() {
        CoreOptions options = new CoreOptions();

        closeNative(options);
    }

    private static native void closeNative(CoreOptions options);

    public static void createServer(String cachePath) {
        createServerNative(cachePath);
    }

    private static native void createServerNative(String cachePath);

    public static CoreResult hostFile(String prefix, CoreOptions options) {
        CoreResult result = hostFileNative(prefix, options);

        switch (result.errorCode) {
            case 0:
                break;
            case -1:
                result.exception = new CoreCouldNotOpenException();
                break;
            case -2:
                result.exception = new CoreEncryptedException();
                break;
            case -3:
                result.exception = new CoreUnknownErrorException();
                break;
            case -4:
                result.exception = new CoreCouldNotTranslateException();
                break;
            case -5:
                result.exception = new CoreUnexpectedFormatException();
                break;
            default:
                result.exception = new CoreUnexpectedErrorCodeException();
                break;
        }

        return result;
    }

    private static native CoreResult hostFileNative(String prefix, CoreOptions options);

    public static void listenServer(int port) {
        listenServerNative(port);
    }

    private static native void listenServerNative(int port);

    public static void stopServer() {
        stopServerNative();
    }

    private static native void stopServerNative();

    public static class CoreResult {
        public int errorCode;

        public Exception exception;

        public List<String> pageNames = new LinkedList<>();
        public List<String> pagePaths = new LinkedList<>();

        public String outputPath;

        public String extension;
    }

    public static class CoreCouldNotOpenException extends RuntimeException {
    }

    public static class CoreEncryptedException extends RuntimeException {
    }

    public static class CoreCouldNotTranslateException extends RuntimeException {
    }

    public static class CoreUnexpectedFormatException extends RuntimeException {
    }

    public static class CoreUnexpectedErrorCodeException extends RuntimeException {
    }

    public static class CoreUnknownErrorException extends RuntimeException {
    }

    public static class CoreCouldNotEditException extends RuntimeException {
    }

    public static class CoreCouldNotSaveException extends RuntimeException {
    }
}
