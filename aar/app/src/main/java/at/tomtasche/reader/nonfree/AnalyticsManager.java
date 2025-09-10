package at.tomtasche.reader.nonfree;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

// 移除Firebase Analytics导入
// import com.google.firebase.analytics.FirebaseAnalytics;

public class AnalyticsManager {

    private boolean enabled;

    // 移除Firebase Analytics实例
    // private FirebaseAnalytics analytics;

    public void initialize(Context context) {
        if (!enabled) {
            // 移除Firebase Analytics调用
            // FirebaseAnalytics.getInstance(context).setAnalyticsCollectionEnabled(false);
            return;
        }

        // 移除Firebase Analytics初始化
        // analytics = FirebaseAnalytics.getInstance(context);
        Log.d("AnalyticsManager", "Analytics disabled for library version");
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public void report(String event) {
        report(event, null, null);
    }

    public void report(String event, String key1, Object value1, String key2, Object value2) {
        if (!enabled) {
            return;
        }

        // 记录到日志而不是Firebase
        Log.d("AnalyticsManager", "Event: " + event + 
              (key1 != null ? ", " + key1 + ": " + value1 : "") + 
              (key2 != null ? ", " + key2 + ": " + value2 : ""));
        
        // 移除Firebase Analytics调用
        // Bundle bundle = new Bundle();
        // if (key1 != null) {
        //     bundle.putString(key1, String.valueOf(value1));
        // }
        // if (key2 != null) {
        //     bundle.putString(key2, String.valueOf(value2));
        // }
        // analytics.logEvent(event, bundle);
    }

    public void report(String event, String key, Object value) {
        report(event, key, value, null, null);
    }

    public void setCurrentScreen(Activity activity, String name) {
        if (!enabled) {
            return;
        }

        // 记录到日志而不是Firebase
        Log.d("AnalyticsManager", "Screen: " + name + ", Class: " + activity.getClass().getSimpleName());
        
        // 移除Firebase Analytics调用
        // Bundle bundle = new Bundle();
        // bundle.putString(FirebaseAnalytics.Param.SCREEN_NAME, name);
        // bundle.putString(FirebaseAnalytics.Param.SCREEN_CLASS, activity.getClass().getSimpleName());
        // analytics.logEvent(FirebaseAnalytics.Event.SCREEN_VIEW, bundle);
    }
    
    // Firebase Analytics 常量替代类
    public static class FirebaseAnalytics {
        public static class Event {
            public static final String VIEW_ITEM = "view_item";
            public static final String SELECT_CONTENT = "select_content";
            public static final String SEARCH = "search";
            public static final String ADD_TO_CART = "add_to_cart";
        }
        
        public static class Param {
            public static final String CONTENT_TYPE = "content_type";
            public static final String ITEM_NAME = "item_name";
            public static final String CONTENT = "content";
        }
    }
}
