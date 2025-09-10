package com.itant.wts.ui.base

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

open class BaseViewModel: ViewModel() {
    val loadingLiveData = MutableLiveData<LoadingBean?>()
}

/*使用：
fun testLoading() {
    loadingLiveData.postValue(LoadingBean())
    launchModelTask(
        {
            delay(8_000L)
        }, onResult = { errorResult, normalResult ->
            loadingLiveData.postValue(null)
            L.e("on result")
        }
    )
}

homeViewModel.loadingLiveData.observe(this) {
    showOrHideLoading(it)
}
*/
