package com.itant.wts.net

import com.blankj.utilcode.util.AppUtils
import com.chuckerteam.chucker.api.ChuckerInterceptor
import com.itant.wts.BuildConfig
import com.miekir.mvvm.context.GlobalContext
import com.miekir.mvvm.task.net.RetrofitManager

/**
 * 网络请求封装
 * @date 2021-8-7 11:32
 * @author 詹子聪
 */
object ApiManager {
    /**
     * 默认的网络请求
     */
    val default by lazy {
        RetrofitManager.getDefault()
            .timeout(5000, 5000, 5000, 5000)
            .addInterceptors(ChuckerInterceptor.Builder(GlobalContext.getContext()).build())
            .printLog(AppUtils.isAppDebug())
            .createApiService(BuildConfig.BASE_URL, ApiService::class.java)
    }
}