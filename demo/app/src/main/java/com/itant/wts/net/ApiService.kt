package com.itant.wts.net

import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query
import retrofit2.http.Streaming
import retrofit2.http.Url


/**
 * 请求接口
 * @date 2021-8-7 11:36
 * @author 詹子聪
 * 统一规则：BaseUrl以/结尾，具体请求不能以/开头
 * 注意：函数必须是suspend的。
 * ① 不加suspend的话，async里的代码会以占据线程的方式执行，发挥不了协程的优势；
 * ② 函数加suspend，返回值不能是Call，否则会报错（Suspend functions should not return Call, as they already execute asynchronously.）
 * Unable to create converter for retrofit2.Call<okhttp3.ResponseBody>
 * ③ 函数不加suspend，返回值必须是Call类型，否则不能在协程调用（Unable to create call adapter for class java.lang.Object），返回值为Call时，记得要调用execute，否则相当于没有执行
 */
interface ApiService {

    /**
     * 获取验证码接口
     */
    @GET("prod-api/api/login/smsCode")
    suspend fun sendSmsCode(@Query("phone") phone: String): BaseResponse<Any>

    @GET("test")
    //suspend fun test(): Any
    suspend fun test(): BaseResponse<String>

    @Streaming
    @GET("upgrade.apk")
    fun getFile(): Call<ResponseBody>

    /**
     * 正确写法1
     */
    /*@GET
    fun downloadApk(@Url url: String): Call<ResponseBody>*/

    /**
     * 正确写法2
     * suspend关键字有额外处理，所以不用Call了
     */
    @GET
    suspend fun downloadApk(@Url url: String): ResponseBody


    /**
     * 动态URL
     * @url需要使用带host的全路径，否则不会更改baseUrl，只会和原baseUrl拼接在一起
     * apiService.yourGet("https://new.api.com/")
     * 使用ResponseBody可以接收非JSON字符串而不报错
     */
    @GET
    suspend fun yourGet(@Url url: String): Response<ResponseBody?>?

    /**
     * 集指平台发短信
     * 将参数类型由Map，改为 MutableMap才能在Body里传Any对象
     * 这个是特殊，不用suspend，因为要拿call来主动调用，且@Body其实是可以放置自定义实体的
     */
    @POST
    fun sendCollectiveMessage(@Url url: String, @Body map: MutableMap<String, Any?>): Call<Response<Any>>

    /**
     * 获取所有道路信息
     */
    //@GET("app/road/loadRoadDatas")
    //suspend fun roadAllData(@Header("Authorization") token: String): NetworkResponse<List<RoadResp>>
}