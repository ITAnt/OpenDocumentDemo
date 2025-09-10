package at.tomtasche.reader.ui.activity;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.text.InputType;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Toast;

// 移除 Google Play Review API 导入
// 移除FirebaseAnalytics导入
// import com.google.firebase.analytics.FirebaseAnalytics;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.MenuProvider;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import at.tomtasche.reader.R;
import at.tomtasche.reader.background.AndroidFileCache;
import at.tomtasche.reader.background.FileLoader;
import at.tomtasche.reader.background.LoaderService;
import at.tomtasche.reader.background.LoaderServiceQueue;
import at.tomtasche.reader.background.StreamUtil;
import at.tomtasche.reader.nonfree.AnalyticsManager;
import at.tomtasche.reader.nonfree.ConfigManager;
import at.tomtasche.reader.nonfree.CrashManager;
import at.tomtasche.reader.ui.SnackbarHelper;
import at.tomtasche.reader.ui.widget.PageView;
import at.tomtasche.reader.ui.widget.ProgressDialogFragment;

public class DocumentFragment extends Fragment implements LoaderService.LoaderListener, ActionBar.TabListener, MenuProvider {

    private static final String SAVED_KEY_LAST_RESULT = "LAST_RESULT";
    private static final String SAVED_KEY_CURRENT_HTML_DIFF = "CURRENT_HTML_DIFF";

    private Handler mainHandler;

    private AnalyticsManager analyticsManager;
    private ConfigManager configManager;
    private CrashManager crashManager;

    private ProgressDialogFragment progressDialog;

    private ViewGroup container;
    private PageView pageView;

    private Menu menu;

    private FileLoader.Result lastResult;

    private String currentHtmlDiff;

    private FileLoader.Result resultOnStart;
    private Throwable errorOnStart;

    private int lastSelectedTab = -1;

    private LoaderServiceQueue serviceQueue;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        this.container = container;

        getActivity().addMenuProvider(this, getActivity());

        return super.onCreateView(inflater, container, savedInstanceState);
    }

    private void initializePageView() {
        if (pageView != null) {
            container.removeAllViews();
            pageView.destroy();
            pageView = null;
        }

        try {
            ViewGroup inflatedView = (ViewGroup) getLayoutInflater().inflate(R.layout.fragment_document, container, true);
            pageView = inflatedView.findViewById(R.id.page_view);

            pageView.setDocumentFragment(this);
        } catch (Throwable t) {
            // can't call crashlytics yet at this point (onActivityCreated not called)

            String errorString = "Please install \"Android System WebView\" and restart the app afterwards.";

            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=com.google.android.webview"));
            startActivity(intent);

            Toast.makeText(getContext(), errorString, Toast.LENGTH_LONG).show();
            getActivity().finishAffinity();
        }
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        mainHandler = new Handler();

        MainActivity mainActivity = (MainActivity) getActivity();
        analyticsManager = mainActivity.getAnalyticsManager();
        configManager = mainActivity.getConfigManager();
        crashManager = mainActivity.getCrashManager();

        serviceQueue = mainActivity.getLoaderServiceQueue();
        serviceQueue.addToQueue(new LoaderServiceQueue.QueueEntry() {
            @Override
            public void onService(LoaderService service) {
                service.setListener(DocumentFragment.this);
            }
        });

        crashManager.log("onActivityCreated");

        if (savedInstanceState != null) {
            crashManager.log("onActivityCreated has savedInstanceState");

            initializePageView();

            lastResult = savedInstanceState.getParcelable(SAVED_KEY_LAST_RESULT);
            if (lastResult != null) {
                crashManager.log("savedInstanceState has lastResult");

                prepareLoad(lastResult.loaderType, false);
            }

            currentHtmlDiff = savedInstanceState.getString(SAVED_KEY_CURRENT_HTML_DIFF);

            pageView.restoreState(savedInstanceState);
        }

        // the app is designed to work fine without this setting, however, it is enabled for performance reasons
        // (avoids redundant reloads of documents) and usability (edits are not lost on orientation change)
        setRetainInstance(true);
    }

    @Override
    public void onCreateMenu(@NonNull Menu menu, @NonNull MenuInflater menuInflater) {
        this.menu = menu;

        menu.findItem(R.id.menu_fullscreen).setVisible(true);
        menu.findItem(R.id.menu_open_with).setVisible(true);
        menu.findItem(R.id.menu_share).setVisible(true);
        menu.findItem(R.id.menu_save).setVisible(true);
        menu.findItem(R.id.menu_print).setVisible(true);

        // the other menu items are dynamically enabled based on the loaded document
        if (lastResult != null) {
            // TODO
            toggleDocumentMenu(true, true);
        }
    }

    @Override
    public boolean onMenuItemSelected(@NonNull MenuItem menuItem) {
        // TODO: handle menu item clicks here. currently done in Activity for historical reasons
        return false;
    }

    @Override
    public void onSaveInstanceState(@NonNull Bundle outState) {
        super.onSaveInstanceState(outState);

        crashManager.log("onSaveInstanceState");

        outState.putParcelable(SAVED_KEY_LAST_RESULT, lastResult);
        outState.putString(SAVED_KEY_CURRENT_HTML_DIFF, currentHtmlDiff);

        pageView.saveState(outState);
    }

    @Override
    public void onStart() {
        super.onStart();

        if (resultOnStart != null) {
            if (errorOnStart == null) {
                onLoadSuccess(resultOnStart);
            } else {
                onError(resultOnStart, errorOnStart);
            }

            resultOnStart = null;
            errorOnStart = null;
        }
    }

    private void prepareLoad(FileLoader.LoaderType loaderType, boolean showProgress) {
        boolean isUpload = false;
        switch (loaderType) {
            case ONLINE:
                isUpload = true;
                break;
            default:
                break;
        }

        if (showProgress) {
            showProgress(isUpload);
        }
    }

    private void loadWithType(FileLoader.LoaderType loaderType, FileLoader.Options options) {
        System.out.println("DocumentFragment: loadWithType called for " + loaderType + " with file " + options.filename);
        prepareLoad(loaderType, true);

        serviceQueue.addToQueue(new LoaderServiceQueue.QueueEntry() {
            @Override
            public void onService(LoaderService service) {
                System.out.println("DocumentFragment: Calling service.loadWithType for " + loaderType);
                service.loadWithType(loaderType, options);
            }
        });
    }

    public void loadUri(Uri uri, boolean persistentUri) {
        loadUri(uri, persistentUri, false);
    }

    public void loadUri(Uri uri, boolean persistentUri, boolean editable) {
        System.out.println("DocumentFragment: loadUri called with " + uri);
        initializePageView();

        FileLoader.Options options = new FileLoader.Options();
        options.originalUri = uri;
        options.persistentUri = persistentUri;
        options.translatable = editable;

        loadWithType(FileLoader.LoaderType.METADATA, options);
    }

    public void reloadUri(boolean translatable) {
        lastResult.options.translatable = translatable;

        loadWithType(lastResult.loaderType, lastResult.options);
    }

    public void prepareSave(Runnable callback, boolean fullSave) {
        if (fullSave) {
            currentHtmlDiff = null;

            callback.run();
        }

        pageView.requestHtml(new PageView.HtmlCallback() {

            @Override
            public void onHtml(String htmlDiff) {
                currentHtmlDiff = htmlDiff;

                callback.run();
            }
        });
    }

    public void save(Uri outFile) {
        if (outFile == null) {
            SnackbarHelper.show(getActivity(), R.string.toast_error_save_nofile, null, true, true);

            return;
        }

        serviceQueue.addToQueue(new LoaderServiceQueue.QueueEntry() {
            @Override
            public void onService(LoaderService service) {
                service.saveAsync(lastResult, outFile, currentHtmlDiff);
            }
        });
    }

    private void unload() {
        toggleDocumentMenu(false);

        resetTabs();
    }

    private void resetTabs() {
        Activity activity = getActivity();
        if (activity != null && activity instanceof AppCompatActivity) {
            ActionBar bar = ((AppCompatActivity) activity).getSupportActionBar();
            if (bar != null) {
                bar.removeAllTabs();
            }
        }

        lastSelectedTab = -1;
    }

    private void toggleDocumentMenu(boolean enabled) {
        toggleDocumentMenu(enabled, enabled);
    }

    private void toggleDocumentMenu(boolean enabled, boolean editEnabled) {
        if (menu == null) {
            if (getActivity() == null || getActivity().isFinishing() || pageView == null) {
                return;
            }

            // menu is not set when loadUri is called via onStart, retry later
            pageView.post(new Runnable() {
                @Override
                public void run() {
                    toggleDocumentMenu(enabled, editEnabled);
                }
            });

            return;
        }

        menu.findItem(R.id.menu_edit).setVisible(editEnabled);

        menu.findItem(R.id.menu_search).setVisible(enabled);
        menu.findItem(R.id.menu_tts).setVisible(enabled);
    }

    private void requestInAppRating(Activity activity) {
        // 移除 Google Play Review API 功能
        // 保持空实现以避免编译错误
        analyticsManager.report("in_app_review_disabled");
    }

    private boolean isActivityReadyForResult(FileLoader.Result result) {
        Activity activity = getActivity();
        if (activity == null || isStateSaved()) {
            resultOnStart = result;

            return false;
        }

        // needs to be saved for errors too for features like "Open With" to work
        lastResult = result;

        resultOnStart = null;
        errorOnStart = null;

        return true;
    }

    @Override
    public void onLoadSuccess(FileLoader.Result result) {
        System.out.println("DocumentFragment: onLoadSuccess called with " + result.partUris.size() + " pages");
        
        if (!isActivityReadyForResult(result)) {
            System.out.println("DocumentFragment: Activity not ready for result, deferring...");
            return;
        }

        Activity activity = getActivity();
        FileLoader.Options options = result.options;

        System.out.println("DocumentFragment: Processing load success for " + result.loaderType + " with " + result.partTitles.size() + " parts");
        analyticsManager.setCurrentScreen(activity, result.loaderType.toString() + "_" + options.fileType);

        resetTabs();

        // 跳过 ActionBar 检查，直接处理文档加载
        List<String> titles = result.partTitles;
        int pages = Math.max(titles.size(), result.partUris.size()); // 使用更安全的页数计算
        System.out.println("DocumentFragment: Calculated pages = " + pages + " (titles: " + titles.size() + ", uris: " + result.partUris.size() + ")");
        
        // 尝试设置 ActionBar（如果可用）
        ActionBar bar = null;
        try {
            bar = ((AppCompatActivity) activity).getSupportActionBar();
            System.out.println("DocumentFragment: ActionBar available: " + (bar != null));
        } catch (Exception e) {
            System.out.println("DocumentFragment: Failed to get ActionBar: " + e.getMessage());
        }
        
        // 处理多页文档的 ActionBar（如果可用）
        if (bar != null && pages > 1) {
            try {
                bar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
                for (int i = 0; i < pages; i++) {
                    ActionBar.Tab tab = bar.newTab();
                    String name = (i < titles.size() && titles.get(i) != null) ? titles.get(i) : "Page " + (i + 1);
                    tab.setText(name);
                    tab.setTabListener(this);
                    bar.addTab(tab);
                }
                bar.setSelectedNavigationItem(0);
                System.out.println("DocumentFragment: ActionBar tabs configured for " + pages + " pages");
            } catch (Exception e) {
                System.out.println("DocumentFragment: Failed to configure ActionBar tabs: " + e.getMessage());
            }
        } else if (bar != null) {
            try {
                bar.setNavigationMode(ActionBar.NAVIGATION_MODE_STANDARD);
            } catch (Exception e) {
                System.out.println("DocumentFragment: Failed to set ActionBar standard mode: " + e.getMessage());
            }
        }

        // 关键修复：无论 ActionBar 是否可用，都要加载内容
        if (pages >= 1 && result.partUris.size() > 0) {
            String url = result.partUris.get(0).toString();
            System.out.println("DocumentFragment: Loading content with URL: " + url);
            loadData(url);
        } else {
            System.out.println("DocumentFragment: No content to load (pages = " + pages + ", uris = " + result.partUris.size() + ")");
        }

        if (result.loaderType == FileLoader.LoaderType.RAW || result.loaderType == FileLoader.LoaderType.ONLINE) {
            offerReopen(activity, options, R.string.toast_hint_unsupported_file, false);
        } else if (result.loaderType == FileLoader.LoaderType.CORE) {
            offerUpload(activity, options, false);
        }

        dismissProgress();

        boolean isPro = getResources().getBoolean(R.bool.DISABLE_TRACKING);
        if (isPro) {
            requestInAppRating(activity);
        } else {
            configManager.getBooleanConfig("show_in_app_rating", new ConfigManager.ConfigListener<Boolean>() {
                @Override
                public void onConfig(String key, Boolean showInAppRating) {
                    if (showInAppRating != null && showInAppRating) {
                        requestInAppRating(activity);
                    }
                }
            });
        }
    }

    @Override
    public void onError(FileLoader.Result result, Throwable error) {
        if (!isActivityReadyForResult(result)) {
            return;
        }

        Activity activity = getActivity();
        FileLoader.Options options = result.options;

        unload();
        dismissProgress();

        int errorDescription;
        if (error instanceof FileNotFoundException) {
            errorDescription = R.string.toast_error_find_file;
        } else if (error instanceof OutOfMemoryError) {
            errorDescription = R.string.toast_error_out_of_memory;
        } else {
            errorDescription = R.string.toast_error_generic;
        }

        // MetadataLoader failed, so there's no point in trying to parse or upload the file
        offerReopen(activity, options, errorDescription, true);
    }

    @Override
    public void onEncrypted(FileLoader.Result result) {
        if (!isActivityReadyForResult(result)) {
            return;
        }

        Activity activity = getActivity();
        FileLoader.Options options = result.options;

        unload();
        dismissProgress();

        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
        builder.setTitle(R.string.toast_error_password_protected);

        final EditText input = new EditText(activity);
        input.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
        builder.setView(input);

        builder.setPositiveButton(getString(android.R.string.ok),
                (dialog, whichButton) -> {
                    options.password = input.getText().toString();

                    // close dialog before progress is shown again
                    dialog.dismiss();

                    if (result.loaderType == FileLoader.LoaderType.CORE) {
                        loadWithType(FileLoader.LoaderType.CORE, options);
                    } else {
                        throw new RuntimeException("encryption not supported for type: " + result.loaderType);
                    }
                });
        builder.setNegativeButton(getString(android.R.string.cancel), null);
        builder.show();
    }

    @Override
    public void onUnsupported(FileLoader.Result result) {
        if (!isActivityReadyForResult(result)) {
            return;
        }

        Activity activity = getActivity();
        FileLoader.Options options = result.options;

        unload();
        dismissProgress();

        if (result.loaderType == FileLoader.LoaderType.CORE) {
            if (serviceQueue.getService().isOnlineSupported(options)) {
                offerUpload(activity, options, true);
            } else {
                offerReopen(activity, options, R.string.toast_error_illegal_file_reopen, true);
            }
        } else if (result.loaderType == FileLoader.LoaderType.ONLINE) {
            offerReopen(activity, options, R.string.toast_error_illegal_file_reopen, true);
        }
    }

    @Override
    public void onSaveSuccess(Uri outFile) {
        currentHtmlDiff = null;

        SnackbarHelper.show(getActivity(), R.string.toast_edit_status_saved, null, false, false);

        loadUri(outFile, true, true);
    }

    @Override
    public void onSaveError() {
        currentHtmlDiff = null;

        SnackbarHelper.show(getActivity(), R.string.toast_error_save_failed, null, true, true);
    }

    private void offerUpload(Activity activity, FileLoader.Options options, boolean invasive) {
        String fileType = options.fileType;
        if (invasive) {
            // 注释掉带参数的report调用，替换为无参调用
            // analyticsManager.report("upload_offer_invasive", FirebaseAnalytics.Param.CONTENT_TYPE, fileType, FirebaseAnalytics.Param.CONTENT, options.originalUri);
            analyticsManager.report("upload_offer_invasive");

            AlertDialog.Builder builder = new AlertDialog.Builder(activity);
            builder.setTitle(R.string.toast_error_illegal_file);
            builder.setMessage(R.string.dialog_upload_file);

            builder.setPositiveButton(getString(android.R.string.ok),
                    new DialogInterface.OnClickListener() {

                        @Override
                        public void onClick(DialogInterface dialog,
                                            int whichButton) {
                            // 注释掉带参数的report调用，替换为无参调用
                            // analyticsManager.report("load_upload", FirebaseAnalytics.Param.CONTENT_TYPE, fileType);
                            analyticsManager.report("load_upload");

                            loadWithType(FileLoader.LoaderType.ONLINE, options);

                            dialog.dismiss();
                        }
                    });
            builder.setNegativeButton(getString(android.R.string.cancel), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int i) {
                    // 注释掉带参数的report调用，替换为无参调用
                    // analyticsManager.report("load_upload_cancel", FirebaseAnalytics.Param.CONTENT_TYPE, fileType);
                    analyticsManager.report("load_upload_cancel");

                    offerReopen(activity, options, R.string.toast_error_illegal_file_reopen, true);

                    dialog.dismiss();
                }
            });

            builder.show();
        } else {
            // 注释掉带参数的report调用，替换为无参调用
            // analyticsManager.report("upload_offer_subtle", FirebaseAnalytics.Param.CONTENT_TYPE, fileType, FirebaseAnalytics.Param.CONTENT, options.originalUri);
            analyticsManager.report("upload_offer_subtle");

            SnackbarHelper.show(activity, R.string.toast_hint_upload_file, new Runnable() {
                @Override
                public void run() {
                    loadWithType(FileLoader.LoaderType.ONLINE, options);
                }
            }, false, false);
        }
    }

    private void offerReopen(Activity activity, FileLoader.Options options, int description, boolean isIndefinite) {
        String fileType = options.fileType;

        // 注释掉带参数的report调用，替换为无参调用
        // analyticsManager.report("reopen_offer", FirebaseAnalytics.Param.CONTENT_TYPE, fileType, FirebaseAnalytics.Param.CONTENT, options.originalUri);
        analyticsManager.report("reopen_offer");

        SnackbarHelper.show(activity, description, new Runnable() {
            @Override
            public void run() {
                doReopen(options, activity, true, false);
            }
        }, isIndefinite, false);
    }

    public void openWith(Activity activity) {
        doReopen(lastResult.options, activity, true, false);
    }

    public void share(Activity activity) {
        doReopen(lastResult.options, activity, true, true);
    }

    private void doReopen(FileLoader.Options options, Activity activity, boolean grantPermission, boolean share) {
        Uri reopenUri;
        Uri cacheUri = options.cacheUri;
        String fileType = options.fileType;

        if (options.fileExists) {
            File cacheFile = AndroidFileCache.getCacheFile(activity, cacheUri);
            File cacheDirectory = AndroidFileCache.getCacheDirectory(cacheFile);

            String reopenFilename = "yourdocument." + options.fileExtension;
            File reopenFile = new File(cacheDirectory, reopenFilename);
            try {
                StreamUtil.copy(cacheFile, reopenFile);

                reopenUri = AndroidFileCache.getCacheFileUri(activity, reopenFile);
            } catch (IOException e) {
                crashManager.log(e);

                reopenUri = options.originalUri;
            }
        } else {
            reopenUri = options.originalUri;
        }

        Intent intent = new Intent();

        String action = share ? Intent.ACTION_SEND : Intent.ACTION_VIEW;
        intent.setAction(action);

        if (!"N/A".equals(fileType)) {
            intent.setDataAndType(reopenUri, fileType);
        } else {
            intent.setData(reopenUri);
        }

        if (share) {
            intent.putExtra(Intent.EXTRA_STREAM, reopenUri);
        }

        if (grantPermission) {
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        }

        String logPrefix = share ? "share" : "reopen";

        Intent chooserIntent = Intent.createChooser(intent, activity.getString(R.string.reopen_chooser_title));

        try {
            activity.startActivity(chooserIntent);

            // 注释掉带参数的report调用，替换为无参调用
            // analyticsManager.report(logPrefix + "_success", FirebaseAnalytics.Param.CONTENT_TYPE, fileType);
            analyticsManager.report(logPrefix + "_success");
        } catch (Throwable e) {
            crashManager.log(e);

            // 移除Firebase Analytics相关代码
            // analyticsManager.report(logPrefix + "_failed", FirebaseAnalytics.Param.CONTENT_TYPE, fileType);
            analyticsManager.report(logPrefix + "_failed");

            if (grantPermission) {
                // if we're trying to reopen the originalUri, the provider might decline the request
                doReopen(options, activity, false, share);
            }
        }
    }

    private void showProgress(boolean isUpload) {
        if (progressDialog == null && getFragmentManager() != null) {
            progressDialog = (ProgressDialogFragment) getFragmentManager()
                    .findFragmentByTag(ProgressDialogFragment.FRAGMENT_TAG);
        }

        if (progressDialog != null) {
            return;
        }

        try {
            progressDialog = new ProgressDialogFragment(isUpload);

            FragmentManager fragmentManager = getFragmentManager();
            if (fragmentManager == null) {
                crashManager.log(new NullPointerException());

                progressDialog = null;

                return;
            }

            progressDialog.show(fragmentManager, ProgressDialogFragment.FRAGMENT_TAG);
        } catch (IllegalStateException e) {
            // sometimes called while activity is in background
            crashManager.log(e);

            progressDialog = null;
        }
    }

    private void dismissProgress() {
        if (progressDialog == null && getFragmentManager() != null) {
            progressDialog = (ProgressDialogFragment) getFragmentManager()
                    .findFragmentByTag(ProgressDialogFragment.FRAGMENT_TAG);
        }

        if (progressDialog != null) {
            try {
                progressDialog.dismiss();
            } catch (IllegalStateException e) {
                // sometimes called while activity is in background
                crashManager.log(e);
            }
        }

        progressDialog = null;
    }

    @Override
    public void onTabSelected(ActionBar.Tab tab, androidx.fragment.app.FragmentTransaction ft) {
        if (lastResult.options.translatable) {
            if (lastSelectedTab >= 0) {
                // I think there was an issue switching tab inside of onTabSelected()
                mainHandler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        ActionBar bar = ((AppCompatActivity) getActivity()).getSupportActionBar();
                        if (bar != null) {
                            bar.setSelectedNavigationItem(lastSelectedTab);
                        }
                    }
                }, 1);

                return;
            }

            lastSelectedTab = tab.getPosition();
        }

        Uri uri = lastResult.partUris.get(tab.getPosition());
        loadData(uri.toString());
    }

    @Override
    public void onTabUnselected(ActionBar.Tab tab, androidx.fragment.app.FragmentTransaction ft) {
    }

    @Override
    public void onTabReselected(ActionBar.Tab tab, androidx.fragment.app.FragmentTransaction ft) {
    }

    private void loadData(String url) {
        System.out.println("DocumentFragment: Loading URL: " + url);
        pageView.loadUrl(url);
        
        // 在页面加载后延迟检查状态
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                System.out.println("DocumentFragment: Checking page status after load...");
                pageView.checkPageStatus();
                
                // 如果页面仍然显示加载中，尝试强制刷新
                pageView.post(new Runnable() {
                    @Override
                    public void run() {
                        System.out.println("DocumentFragment: Force refreshing page if still loading...");
                        pageView.loadUrl("javascript:console.log('DocumentFragment: Force refresh executed');");
                    }
                });
            }
        }, 3000); // 3秒后检查页面状态
        
        // 添加一个更长的超时来强制处理卡住的情况
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                System.out.println("DocumentFragment: 8-second timeout - checking if page is still loading");
                // 这里可以添加强制显示错误消息或重新加载的逻辑
                pageView.loadUrl("javascript:" +
                        "console.log('DocumentFragment: 8-second timeout check');" +
                        "if (document.body && document.body.innerHTML.length < 100) {" +
                        "  console.log('DocumentFragment: Page appears to be empty or loading, this may be the issue');" +
                        "  document.body.innerHTML = '<h1>文档加载完成</h1><p>如果您看到此消息，说明HTTP服务器工作正常，但原始内容可能有问题。</p><p>URL: ' + window.location.href + '</p>';" +
                        "} else {" +
                        "  console.log('DocumentFragment: Page has content, length: ' + document.body.innerHTML.length);" +
                        "}");
            }
        }, 8000); // 8秒后强制检查
    }

    public PageView getPageView() {
        return pageView;
    }

    public boolean hasLastResult() {
        return lastResult != null;
    }

    public String getLastFileType() {
        return lastResult.options.fileType;
    }

    public CrashManager getCrashManager() {
        return crashManager;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();

        LoaderService service = serviceQueue.getService();
        if (service != null) {
            service.setListener(null);
        }

        if (pageView != null) {
            pageView.destroy();
        }
    }
}