package com.itant.wts.utils

import com.itant.wts.R
import com.miekir.mvvm.context.GlobalContext

object TimeUtils {
    /**
     * 编译时间戳
     */
    val buildTimeMillis by lazy {
        try {
            GlobalContext.getContext().getString(R.string.build_time).toLong()
        } catch (e: Exception) {
            0L
        }
    }
}