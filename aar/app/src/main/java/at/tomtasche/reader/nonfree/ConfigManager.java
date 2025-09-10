package at.tomtasche.reader.nonfree;

import android.net.Uri;

// 移除 Google Play Services Tasks 导入
// 移除Firebase Remote Config导入
// import com.google.firebase.remoteconfig.FirebaseRemoteConfig;

import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.TimeoutException;

import androidx.annotation.NonNull;

import at.tomtasche.reader.R;
import at.tomtasche.reader.ui.activity.MainActivity;

public class ConfigManager {

    private boolean enabled;

    private boolean loaded;

    // 移除Firebase Remote Config变量
    // private FirebaseRemoteConfig remoteConfig;

    private final List<Runnable> callbacks;

    public ConfigManager() {
        callbacks = new LinkedList<>();
    }

    public void initialize() {
        if (!enabled) {
            return;
        }

        // 移除Firebase Remote Config初始化
        // remoteConfig = FirebaseRemoteConfig.getInstance();
        // remoteConfig.fetchAndActivate().addOnCompleteListener(new OnCompleteListener<Boolean>() {
        //     @Override
        //     public void onComplete(@NonNull Task<Boolean> task) {

        // 直接设置为已加载状态
        loaded = true;
        
        // 调用所有回调
        for (Runnable callback : callbacks) {
            callback.run();
        }
        callbacks.clear();
    }

    public boolean isLoaded() {
        if (!enabled) {
            return true;
        }

        return loaded;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public void getBooleanConfig(String key, ConfigListener<Boolean> configListener) {
        if (!enabled) {
            configListener.onConfig(key, null);
            return;
        }

        synchronized (callbacks) {
            if (!loaded) {
                callbacks.add(new Runnable() {
                    @Override
                    public void run() {
                        getBooleanConfig(key, configListener);
                    }
                });

                return;
            }
        }

        // 默认返回false，移除对remoteConfig的引用
        boolean value = false; // remoteConfig.getBoolean(key);
        configListener.onConfig(key, value);
    }

    public boolean getBooleanConfig(String key) {
        if (!enabled) {
            return false;
        }

        // 默认返回false，移除对remoteConfig的引用
        return false; // remoteConfig.getBoolean(key);
    }

    public interface ConfigListener<T> {

        void onConfig(String key, T value);
    }
}
