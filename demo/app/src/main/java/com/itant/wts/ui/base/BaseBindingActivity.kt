package com.itant.wts.ui.base

import android.content.res.Configuration
import androidx.viewbinding.ViewBinding
import com.miekir.mvvm.core.view.base.BasicBindingActivity
import com.miekir.mvvm.widget.loading.DefaultTaskLoading
import com.miekir.mvvm.widget.loading.TaskLoading


/**
 * 开启点击空白处隐藏软键盘enableTouchSpaceHideKeyboard()后，需要在根布局配置
 * android:focusable="true"
 * android:focusableInTouchMode="true"
 * 否则焦点乱飞，比如点击提交按钮，焦点被上一个输入框获取了
 *
 * 注意：不要在进入Activity的时候隐藏软键盘，因为有些界面一进来就需要弹出软键盘，onPause()隐藏就好了
 * 如果特殊界面有需求，可以特殊处理 -- 在特定界面进来时隐藏
 */
abstract class BaseBindingActivity<VB : ViewBinding> : BasicBindingActivity<VB>() {
    /**
     * 加载框
     */
    private var loadingDialog: TaskLoading? = null

    /**
     * 显隐加载框，可不使用[DefaultTaskLoading]，使用自定义的Dialog也可以，这里只是一个简单示例
     */
    protected fun showLoadingDialog(loadingBean: LoadingBean? = null) {
        if (loadingDialog!= null) {
            return
        }
        loadingDialog = DefaultTaskLoading().apply {
            newLoadingDialog(this@BaseBindingActivity).apply {
                loadingBean?.cancelable?.let {
                    setCancelable(it)
                }
            }
            show()
        }
    }

    protected fun hideLoadingDialog() {
        loadingDialog?.dismiss()
        loadingDialog = null
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
    }


    override fun enableHighRefreshRate(): Boolean {
        // 启用高刷新率
        return true
    }


    override fun enableTouchSpaceHideKeyboard(): Boolean {
        return true
    }

    /**
     * 引入动画可以减弱requestPermissionsForResult里startActivity时权限对话框闪烁的问题，但正确的做法应该是
     * 先启动界面，再请求权限，权限被拒绝就关闭界面
     */
    override fun enableStartAnimation(): Boolean {
        return true
    }

    override fun enableDestroyAnimation(): Boolean {
        return true
    }
}