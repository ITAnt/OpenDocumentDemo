使用databinding，建立BindingAdapter，增加themeBackground，themeColor等属性，然后传的值是字符串作为key，
比如themeBgColor1，对应主题1为#FFFFFF，对应主题2为#000000，可用模板方法模式创建色板实例，传入主题色，生成各种辅助色，
对应着各个key，获取的时候，直接使用该实例和对应的key获取对应颜色值。
```
public class BindUtils {
public static int color = Color.parseColor("#000000");

    @BindingAdapter("bgColor")
    public static void setBackgroundColor(View view, String holder) {
        view.setBackgroundColor(color);
    }
}



<LinearLayout
android:layout_width="match_parent"
android:layout_height="match_parent"
android:orientation="vertical"
android:padding="16dp"
app:bgColor='@{""}'>



BindUtils.color = Color.parseColor("#FFFFFF")
recreate()
```

Android的视图树渲染之后，界面控件已经展示了，如果要改变为新的语言和主题，必须重新开始渲染。
①最笨但最简单稳定的做法：重启后生效，但体验非常不好；
②Activity recreate()，效果较差，页面可能会闪动，浏览位置丢失；
③使用自定义View，切换后通知背景、文字重新绘制，需要统一处理，自定义View等，工作量可能比较大。
④Activity+Fragment，切换的时候，重新加载Fragment，控件重新渲染，但位置还可以停留到离开的位置