package com.itant.wts.ui.home

import at.tomtasche.reader.ui.activity.MainActivity
import com.blankj.utilcode.util.ToastUtils
import com.itant.wts.databinding.ActivityHomeBinding
import com.itant.wts.ui.base.BaseBindingActivity
import com.itant.wts.ui.home.fragment.FragmentAdapter
import com.miekir.mvvm.core.view.base.withLoadingDialog
import com.miekir.mvvm.core.vm.base.viewModel
import com.miekir.mvvm.extension.openActivity
import com.miekir.mvvm.extension.setSingleClick

/**
 * 首页
 * activity不要做定时任务，如有，需要判断是否已destroyed，否则拿到的view是空会导致闪退，
 * 所以不能滥用MutableLiveData，销毁的时候记得removeObserver
 */
class HomeActivity : BaseBindingActivity<ActivityHomeBinding>() {

    override fun onBindingInflate() = ActivityHomeBinding.inflate(layoutInflater)

    private val homeViewModel: HomeViewModel by viewModel()

    /**
     * AndroidStudio有Bug，如果是直接运行跑起来的话，按Home键后重新从桌面进入Activity会重新触发onCreate(默认启动模式)
     */
    override fun onInit() {
        binding.btnTest.setSingleClick {
            openActivity<MainActivity>()
            ToastUtils.showLong("Hello World")
            withLoadingDialog {
                homeViewModel.testLoading2()
            }
            //homeViewModel.testLoading()
        }

        binding.vpMain.adapter = FragmentAdapter(this)
    }

    override fun enableDestroyAnimation(): Boolean {
        return false
    }
}