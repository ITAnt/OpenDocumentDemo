package com.itant.wts.ui.home.fragment

import com.itant.wts.databinding.FragmentTestBinding
import com.miekir.mvvm.core.view.base.BasicActivity
import com.miekir.mvvm.core.view.base.BasicBindingFragment
import com.miekir.mvvm.core.view.base.withLoadingDialog
import com.miekir.mvvm.core.vm.base.viewModel
import com.miekir.mvvm.extension.setSingleClick

class TestFragment: BasicBindingFragment<FragmentTestBinding>() {
    override fun onBindingInflate() = FragmentTestBinding.inflate(layoutInflater)

    private val viewModel by viewModel<TestViewModel>()

    override fun onInit() {
        // 在 Fragment 中使用 LiveData 时，为了确保在视图销毁时不会出现空指针异常和不必要的资源消耗，应该使用 observe(viewLifecycleOwner) 来绑定 LiveData 的观察者到 Fragment 视图的生命周期。
        //viewModel.initHistoryLiveData.observe(viewLifecycleOwner)

        binding.btnFragment.setSingleClick {
            (requireActivity() as? BasicActivity)?.withLoadingDialog {
                viewModel.go()
            }
        }
    }
}