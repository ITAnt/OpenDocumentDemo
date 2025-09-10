package com.itant.wts.ui.home.fragment

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.viewpager2.adapter.FragmentStateAdapter

/**
 * 千万不能在Fragment直接粗暴使用FragmentStateAdapter(requireActivity())，会造成内存泄漏（比如在单Activity应用里）
 * 如果直接父亲是Fragment，要直接使用Fragment参数，而不是越级使用Activity参数
 */
class FragmentAdapter: FragmentStateAdapter {

    constructor(fragmentActivity: FragmentActivity) : super(fragmentActivity)

    constructor(fragment: Fragment) : super(fragment)
    override fun getItemCount(): Int {
        return 3
    }

    override fun createFragment(position: Int): Fragment {
        // 构造子页面
        val fragment = when (position) {
            0 -> TestFragment()
            1 -> TestFragment()
            2 -> TestFragment()
            else -> TestFragment()
        }
        return fragment
    }
}