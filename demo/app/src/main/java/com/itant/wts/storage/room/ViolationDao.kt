package com.itant.wts.storage.room

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import kotlinx.coroutines.flow.Flow

/**
 * 查询方法如果返回LiveData或Flow，可能不需要suspend，因为LiveData本身是生命周期感知的，会自动在后台线程处理。但如果是直接返回List<User>，可能需要suspend来确保异步执行。
 */
@Dao
interface ViolationDao {
    @Insert
    fun insert(violationBean: ViolationBean)

    @Delete
    fun delete(violationBean: ViolationBean)

    @Update
    fun update(violationBean: ViolationBean)

    /**
     * 删除表的所有数据
     */
    @Query("DELETE FROM t_violation")
    fun deleteAll()

    /**
     * 重置ID，让ID从1开始（似乎不能奏效）
     * 通过@Query注解里query语句删除数据库记录也会触发flow回调，即使是删除了多个记录，也只会触发一次回调
     */
    @Query("DELETE FROM sqlite_sequence where name='t_violation'")
    fun resetId()

    @get:Query("SELECT * FROM t_violation where failure=0 order by violationTime desc")
    val allViolation: List<ViolationBean>

    /**
     * 获取今天的所有违章记录
     */
    @Query("SELECT * FROM t_violation where failure=0 AND violationTime >= :start AND violationTime < :end")
    fun allViolationForToday(start: Long, end: Long): List<ViolationBean>

    /**
     * Flow不支持动态参数，这里通过一个无参的查询作为跳板，触发动态参数查询
     */
    @Query("SELECT count(*) FROM t_violation")
    fun countViolation(): Flow<Int>

    /**
     * 根据字符串查询
     */
    @Query("SELECT * FROM t_violation WHERE message='ssssssssss' limit 1")
    fun hardQuery(): ViolationBean?
}
