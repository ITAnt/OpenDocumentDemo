package at.tomtasche.reader.ui.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.util.AttributeSet;
import android.util.Base64;
import android.util.Base64InputStream;
import android.webkit.DownloadListener;
import android.webkit.JavascriptInterface;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;

import androidx.annotation.Keep;
import androidx.webkit.WebSettingsCompat;
import androidx.webkit.WebViewFeature;
import at.tomtasche.reader.background.AndroidFileCache;
import at.tomtasche.reader.background.OnlineLoader;
import at.tomtasche.reader.background.StreamUtil;
import at.tomtasche.reader.nonfree.CrashManager;
import at.tomtasche.reader.ui.ParagraphListener;
import at.tomtasche.reader.ui.activity.DocumentFragment;

@SuppressLint("SetJavaScriptEnabled")
public class PageView extends WebView implements ParagraphListener {

    private ParagraphListener paragraphListener;

    private DocumentFragment documentFragment;
    private CrashManager crashManager;

    private HtmlCallback htmlCallback;

    /**
     * sometimes the page stays invisible after reporting progress 100: https://stackoverflow.com/q/48082474/198996
     * <p>
     * this seems to happen if progress 100 is reported before finish is called.
     * therefore we set a timer in finish that checks if commit was ever called and reload if not.
     */
    private final Handler buggyWebViewHandler;
    private boolean wasCommitCalled = false;

    @SuppressLint("AddJavascriptInterface")
    public PageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);

        buggyWebViewHandler = new Handler();

        WebSettings settings = getSettings();
        settings.setBuiltInZoomControls(true);
        settings.setDisplayZoomControls(false);
        settings.setSupportZoom(true);
        settings.setDefaultTextEncodingName(StreamUtil.ENCODING);
        settings.setJavaScriptEnabled(true);
        settings.setLoadWithOverviewMode(true);
        settings.setUseWideViewPort(true);
        settings.setAllowFileAccess(true);

        //WebView.setWebContentsDebuggingEnabled(true);

        addJavascriptInterface(this, "paragraphListener");

        setKeepScreenOn(true);
        try {
            Method method = context.getClass().getMethod(
                    "setSystemUiVisibility", Integer.class);
            method.invoke(context, 1);
        } catch (Exception e) {
        }

        setWebViewClient(new WebViewClient() {

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                
                System.out.println("PageView: onPageFinished - " + url);
                
                // 在页面加载完成后立即检查odr对象状态
                loadUrl("javascript:" +
                        "console.log('PageView: Page loaded, checking odr object...');" +
                        "if (typeof odr !== 'undefined') {" +
                        "  console.log('PageView: odr object exists, type: ' + typeof odr);" +
                        "  if (odr.generateDiff) {" +
                        "    console.log('PageView: odr.generateDiff exists');" +
                        "  } else {" +
                        "    console.log('PageView: odr.generateDiff is missing');" +
                        "  }" +
                        "} else {" +
                        "  console.log('PageView: odr object is undefined');" +
                        "}" +
                        "console.log('PageView: Document ready state: ' + document.readyState);" +
                        "console.log('PageView: Document title: ' + document.title);");

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    buggyWebViewHandler.postDelayed(new Runnable() {

                        @Override
                        public void run() {
                            if (!wasCommitCalled) {
                                crashManager.log(new RuntimeException("commit was not called"));

                                loadUrl(url);
                            }
                        }
                    }, 2500);
                }
            }

            @Override
            public void onPageCommitVisible(WebView view, String url) {
                wasCommitCalled = true;
            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                if (url.startsWith(OnlineLoader.GOOGLE_VIEWER_URL) || url.startsWith(OnlineLoader.MICROSOFT_VIEWER_URL) || url.contains("officeapps.live.com/")) {
                    return false;
                } else {
                    try {
                        getContext().startActivity(
                                new Intent(Intent.ACTION_VIEW, Uri.parse(url)));

                        return true;
                    } catch (Exception e) {
                        crashManager.log(e);

                        return false;
                    }
                }
            }
        });

        // taken from: https://stackoverflow.com/a/10069265/198996
        setDownloadListener(new DownloadListener() {
            public void onDownloadStart(String url, String userAgent,
                                        String contentDisposition, String mimetype,
                                        long contentLength) {
                try {
                    getContext().startActivity(
                            new Intent(Intent.ACTION_VIEW, Uri.parse(url)));
                } catch (Exception e) {
                    crashManager.log(e);
                }
            }
        });
    }

    public void toggleDarkMode(boolean isDarkEnabled) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            setForceDarkAllowed(isDarkEnabled);
        }

        if (WebViewFeature.isFeatureSupported(WebViewFeature.ALGORITHMIC_DARKENING)) {
            WebSettingsCompat.setAlgorithmicDarkeningAllowed(getSettings(), isDarkEnabled);
        } else if (WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK)) {
            WebSettingsCompat.setForceDark(getSettings(), isDarkEnabled ? WebSettingsCompat.FORCE_DARK_AUTO : WebSettingsCompat.FORCE_DARK_OFF);
        }
    }

    @Override
    public void loadUrl(String url) {
        wasCommitCalled = false;

        super.loadUrl(url);
    }

    public void setDocumentFragment(DocumentFragment documentFragment) {
        this.documentFragment = documentFragment;
        this.crashManager = documentFragment.getCrashManager();
    }

    public void setParagraphListener(ParagraphListener paragraphListener) {
        this.paragraphListener = paragraphListener;
    }

    public void getParagraph(final int index) {
        post(new Runnable() {

            @Override
            public void run() {
                loadUrl("javascript:var children = document.body.childNodes; "
                        + "if (children.length <= " + index + ") { "
                        + "paragraphListener.end();" + "} else {"
                        + "var child = children[" + index + "]; "
                        + "if (child && child.nodeName.toLowerCase() != 'script' && child.innerText) { "
                        + "paragraphListener.paragraph(child.innerText); "
                        + "} else { " + "paragraphListener.increaseIndex(); "
                        + "} }");
            }
        });
    }

    public void requestHtml(HtmlCallback callback) {
        this.htmlCallback = callback;

        // 添加超时和错误检测机制，专门处理AAR环境中的问题
        Handler timeoutHandler = new Handler();
        Runnable timeoutRunnable = new Runnable() {
            @Override
            public void run() {
                if (htmlCallback != null) {
                    System.err.println("PageView: HTML request timeout - odr object may not be available in AAR environment");
                    htmlCallback.onHtml("");
                    htmlCallback = null;
                }
            }
        };
        
        // 设置5秒超时
        timeoutHandler.postDelayed(timeoutRunnable, 5000);

        // 检查odr对象是否存在并调用generateDiff
        loadUrl("javascript:" +
                "try {" +
                "  console.log('PageView: requestHtml called, checking odr object...');" +
                "  if (typeof odr !== 'undefined' && odr.generateDiff) {" +
                "    console.log('PageView: odr object found, calling generateDiff');" +
                "    var result = odr.generateDiff();" +
                "    console.log('PageView: generateDiff result length: ' + (result ? result.length : 0));" +
                "    window.paragraphListener.sendHtml(result || '');" +
                "  } else {" +
                "    console.log('PageView: odr object not found - likely AAR environment');" +
                "    console.log('PageView: typeof odr = ' + typeof odr);" +
                "    window.paragraphListener.sendHtml('');" +
                "  }" +
                "} catch(e) {" +
                "  console.error('PageView: Error calling generateDiff: ' + e.message);" +
                "  console.error('PageView: Error stack: ' + e.stack);" +
                "  window.paragraphListener.sendHtml('');" +
                "}");
    }
    
    // 添加一个新方法来主动检查页面状态
    public void checkPageStatus() {
        System.out.println("PageView: Checking page status...");
        loadUrl("javascript:" +
                "console.log('PageView: Manual page status check');" +
                "console.log('PageView: Document ready state: ' + document.readyState);" +
                "console.log('PageView: Document title: ' + document.title);" +
                "console.log('PageView: Document URL: ' + document.URL);" +
                "console.log('PageView: Document body innerHTML length: ' + (document.body ? document.body.innerHTML.length : 'no body'));" +
                "console.log('PageView: typeof odr = ' + typeof odr);" +
                "if (typeof odr !== 'undefined') {" +
                "  console.log('PageView: odr object properties: ' + Object.keys(odr));" +
                "  if (odr.generateDiff) {" +
                "    console.log('PageView: odr.generateDiff is available');" +
                "  } else {" +
                "    console.log('PageView: odr.generateDiff is NOT available');" +
                "  }" +
                "} else {" +
                "  console.log('PageView: odr object is completely undefined');" +
                "}" +
                "var scripts = document.getElementsByTagName('script');" +
                "console.log('PageView: Found ' + scripts.length + ' script tags');" +
                "for (var i = 0; i < scripts.length; i++) {" +
                "  var src = scripts[i].src || 'inline';" +
                "  console.log('PageView: Script ' + i + ': ' + src);" +
                "}" +
                "// 检查页面是否显示'正在加载'消息" +
                "var loadingElements = document.querySelectorAll('*');" +
                "var foundLoading = false;" +
                "for (var i = 0; i < loadingElements.length; i++) {" +
                "  var text = loadingElements[i].textContent || loadingElements[i].innerText;" +
                "  if (text && (text.includes('正在加载') || text.includes('loading') || text.includes('Loading'))) {" +
                "    console.log('PageView: Found loading message in element: ' + loadingElements[i].tagName);" +
                "    console.log('PageView: Loading message text: ' + text.substring(0, 100));" +
                "    foundLoading = true;" +
                "  }" +
                "}" +
                "if (!foundLoading) {" +
                "  console.log('PageView: No loading message found in page');" +
                "}");
    }

    @JavascriptInterface
    @Keep
    public void sendHtml(String htmlDiff) {
        if (htmlCallback != null) {
            System.out.println("PageView: Received HTML diff, length: " + (htmlDiff != null ? htmlDiff.length() : 0));
            if (htmlDiff == null || htmlDiff.isEmpty()) {
                System.out.println("PageView: Empty HTML diff received - this is expected in AAR environment");
            }
            htmlCallback.onHtml(htmlDiff);
            htmlCallback = null; // 清除回调，防止重复调用和超时处理冲突
        }
    }

    @JavascriptInterface
    @Keep
    public void sendFile(String base64) {
        try {
            File tmpFile = AndroidFileCache.createCacheFile(getContext());

            ByteArrayInputStream inputStream = new ByteArrayInputStream(base64.getBytes(StreamUtil.ENCODING));
            Base64InputStream baseInputStream = new Base64InputStream(inputStream, Base64.NO_WRAP);
            try {
                StreamUtil.copy(baseInputStream, tmpFile);
            } finally {
                inputStream.close();
            }

            post(new Runnable() {
                @Override
                public void run() {
                    documentFragment.loadUri(AndroidFileCache.getCacheFileUri(getContext(), tmpFile), false);
                }
            });
        } catch (IOException e) {
            crashManager.log(e);
        }
    }

    @Override
    @Keep
    @JavascriptInterface
    public void paragraph(String text) {
        paragraphListener.paragraph(text);
    }

    @Override
    @Keep
    @JavascriptInterface
    public void increaseIndex() {
        paragraphListener.increaseIndex();
    }

    @Override
    @Keep
    @JavascriptInterface
    public void end() {
        paragraphListener.end();
    }

    public interface HtmlCallback {

        void onHtml(String htmlDiff);
    }
}
