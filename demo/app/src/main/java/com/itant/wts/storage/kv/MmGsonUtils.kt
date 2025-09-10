package com.itant.wts.storage.kv

import com.google.gson.Gson

internal object MmGsonUtils {
    val mmGson: Gson by lazy { Gson() }


    val isGsonAvailable: Boolean by lazy {
        try {
            Class.forName("com.google.gson.Gson")
            true
        } catch (e: Exception) {
            false
        }
    }
}