package com.itant.wts.storage.room

import androidx.annotation.Keep
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * 注意：KSP不允许Boolean类型的变量名以is开头
 * @Ignore代替transient关键字
 */
@Keep
@Entity(tableName = "t_violation")
class ViolationBean {
    /**
     * 主键自增长
     * 如果服务器返回来的实体有id字段，那么要用@Ignore忽略，或者自定义在数据库中的key，
     * 如：@ColumnInfo(name = "column_name")，其中 column_name 是数据库中的实际列名，查询的时候还是直接查询变量即可，不要查真实列名，因为已经做了映射。
     */
    @PrimaryKey(autoGenerate = true)
    var id: Long = 0L

    /**
     * JSON字段为sId，存到数据库字段为serverId
     */
    @ColumnInfo(name = "serverId")
    var sId: String = ""

    //车牌号码 有默认值不能是val，必须写成var
    /*@NonNull @ColumnInfo(name = "stop_name")*/ var carNum: String? = null

    var failure: Int = 0

    var violationTime: Long = 0L

    var message: String = ""
}