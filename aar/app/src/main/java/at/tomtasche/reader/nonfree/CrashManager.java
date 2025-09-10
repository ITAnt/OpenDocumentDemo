package at.tomtasche.reader.nonfree;

import android.net.Uri;
import android.util.Log;

// 移除Firebase Crashlytics导入
// import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.concurrent.TimeoutException;

public class CrashManager {

    private boolean enabled;

    // 移除Firebase Crashlytics实例
    // private FirebaseCrashlytics crashlytics;

    public void initialize() {
        if (!enabled) {
            // 移除Firebase Crashlytics调用
            // FirebaseCrashlytics.getInstance().setCrashlyticsCollectionEnabled(false);
            return;
        }

        // 移除Firebase Crashlytics初始化
        // crashlytics = FirebaseCrashlytics.getInstance();
        Log.d("CrashManager", "Crash reporting disabled for library version");

        // 保留TimeoutException处理逻辑，但使用日志记录而不是Crashlytics
        final Thread.UncaughtExceptionHandler defaultUncaughtExceptionHandler =
                Thread.getDefaultUncaughtExceptionHandler();
        Thread.setDefaultUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
            @Override
            public void uncaughtException(Thread t, Throwable e) {
                if (t.getName().equals("FinalizerWatchdogDaemon") && e instanceof TimeoutException) {
                    log(e);
                } else {
                    defaultUncaughtExceptionHandler.uncaughtException(t, e);
                }
            }
        });
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public void log(String message) {
        if (!enabled) {
            return;
        }

        // 使用Android日志记录而不是Crashlytics
        Log.e("CrashManager", message);
        // 移除Firebase Crashlytics调用
        // crashlytics.log(message);
    }

    public void log(Throwable throwable) {
        if (!enabled) {
            return;
        }

        // 使用Android日志记录而不是Crashlytics
        Log.e("CrashManager", Log.getStackTraceString(throwable));
        // 移除Firebase Crashlytics调用
        // crashlytics.recordException(throwable);
    }

    public void log(Uri uri) {
        log(uri.toString());
    }
    
    // 添加接受Throwable和Uri参数的log方法
    public void log(Throwable throwable, Uri uri) {
        if (!enabled) {
            return;
        }
        
        // 记录异常和URI信息
        Log.e("CrashManager", "Error with URI: " + uri.toString());
        Log.e("CrashManager", Log.getStackTraceString(throwable));
    }
}
