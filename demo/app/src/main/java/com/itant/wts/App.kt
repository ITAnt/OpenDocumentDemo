package com.itant.wts

import android.app.Application
import android.content.Context
import com.blankj.utilcode.util.AppUtils
import com.itant.wts.widget.AnimationLoading
import com.miekir.mvvm.MvvmManager
import com.miekir.mvvm.core.view.anim.SlideAnimation
import com.miekir.mvvm.log.ILogHandler
import com.miekir.mvvm.log.L
import com.tencent.mars.xlog.Log
import com.tencent.mars.xlog.Xlog
import com.tencent.mmkv.MMKV
import java.io.File

class App: Application() {

    companion object {
        init {
            System.loadLibrary("c++_shared")
            System.loadLibrary("marsxlog")
        }
    }

    override fun onCreate() {
        super.onCreate()
        initXlog()
        initMvvm()
        L.d("APP初始化: ${AppUtils.getAppVersionName()}(${AppUtils.getAppVersionCode()})")
    }

    private fun initMvvm() {
        MMKV.initialize(applicationContext)
        MvvmManager.getInstance()
            .activityAnimation(SlideAnimation())
            //.globalTaskLoading(DefaultTaskLoading::class.java)
            .globalTaskLoading(AnimationLoading::class.java)

        // 日志打印委托给xlog
        val defaultTag = getString(R.string.app_name).replace(" ", "")
        val logHandler = object : ILogHandler {
            override fun d(tag: String?, message: String?) {
                Log.d(tag ?: defaultTag, message)
                Log.appenderFlush()
            }

            override fun i(tag: String?, message: String?) {
                Log.i(tag ?: defaultTag, message)
                Log.appenderFlush()
            }

            override fun e(tag: String?, message: String?) {
                Log.e(tag ?: defaultTag, message)
                Log.appenderFlush()
            }
        }
        L.setLogHandler(logHandler)
    }

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        initXcrash()
    }

    /**
     * 日志收集
     */
    private fun initXlog() {
        try {
            val cachePath = getExternalFilesDir("xlogs")?.absoluteFile?.absolutePath ?: File(
                externalCacheDir?.absolutePath,
                "xlogs"
            ).absoluteFile.absolutePath
            val file = File(cachePath)
            if (!file.exists()) {
                file.mkdirs()
            }
            val xlog = Xlog()
            Log.setLogImp(xlog)
            // 这里的cacheDays不是留存日志时间，而是日志停留在缓存多久，0的话会马上写到xlog里，留存时间写死是10天，这里AppednerModeSync存在一个bug：不输出最后一行日志到文本
            Log.appenderOpen(Xlog.LEVEL_DEBUG, Xlog.AppednerModeAsync, cachePath, cachePath, "log", 0)
            Log.setConsoleLogOpen(AppUtils.isAppDebug())
            Log.d("xlog", "日志打印输出路径：${cachePath}")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    /**
     * 崩溃收集
     */
    private fun initXcrash() {
        /*try {
            val params = XCrash.InitParameters()
            val crashLogDir = getExternalFilesDir("xcrash")?.absoluteFile?.absolutePath ?: File(
                externalCacheDir?.absolutePath,
                "xcrash"
            ).absolutePath
            // 此时上下文还没获取，不能直接调用日志打印
            //L.d("xcrash", "崩溃日志路径：$crashLogDir")
            params.setLogDir(crashLogDir)
            XCrash.init(this, params)
        } catch (e: Exception) {
            e.printStackTrace()
        }*/
    }
}