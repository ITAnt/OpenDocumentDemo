package com.itant.wts.ui.home

import androidx.lifecycle.ViewModel
import com.itant.wts.net.ApiManager
import com.miekir.mvvm.log.L
import com.miekir.mvvm.task.TaskJob
import com.miekir.mvvm.task.launchModelTask
import kotlinx.coroutines.delay


/**
 * finish调用后，ViewModel的onCleared先被调用，Activity的onDestroy才被调用
 */
class HomeViewModel: ViewModel() {

    fun test(): TaskJob {
        return launchModelTask(
            {
                val map = HashMap<String, Any?>()
                map["phone"] = "12345678901"
                ApiManager.default.sendCollectiveMessage(
                    "https://apifoxmock.com/m1/5054683-0-default/sendCollectiveMessage",
                    map
                ).execute()
            }, onSuccess = {
                L.e("post test result: ${it?.code()}")
            }, onFailure = { code, message, exception ->
                L.e("post test result: $code, $message, $exception")
            }
        )
    }

    fun testLoading2(): TaskJob {
        return launchModelTask(
            {
                delay(10_000L)
            }
        )
    }
}