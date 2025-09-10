package at.tomtasche.reader.nonfree;

import android.app.Activity;
import android.widget.LinearLayout;

public class AdManager {

    private boolean enabled = false;

    public void initialize(Activity activity, AnalyticsManager analyticsManager, CrashManager crashManager, ConfigManager configManager) {
        // 移除 Google Play Services 广告功能
        // 保持空实现以避免编译错误
    }

    public void setEnabled(boolean enabled) {
        this.enabled = false; // 始终禁用广告
    }

    public void setAdContainer(LinearLayout adContainer) {
        // 空实现
    }

    public void showGoogleAds() {
        // 空实现 - 不显示广告
    }

    public void removeAds() {
        // 空实现
    }

    public void destroyAds() {
        // 空实现
    }
}