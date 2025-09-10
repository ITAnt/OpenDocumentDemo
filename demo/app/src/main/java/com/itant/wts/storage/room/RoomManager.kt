package com.itant.wts.storage.room

import androidx.room.Database
import androidx.room.Room.databaseBuilder
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.blankj.utilcode.util.Utils

/**
 * version在数据库结构没有发生改变，即没有迁移代码时不要更改！
 * 每一个version的变动必须有相应的AutoMigration或者addMigrations，如果只定义了1-2的migration，用户直接从1升级到3，
 * 但没有定义2-3的migration，那么room数据库就会失败，引发一系列问题。
 *
 * 策略：Room 可以自动处理简单变更（如添加字段、创建新表）。对于复杂变更（如重命名表 / 字段、数据类型转换），仍需使用自定义 Migration
 *
 * version增加的时候，gradle的versionCode版本也要增加，否则用户安装了新版本后还可以安装旧版本，会导致闪退
 */
@Database(
    version = 1,
    entities = [ViolationBean::class/*, UserBean::class, RoadBean::class, PictureBean::class*/],
    exportSchema = true, // 自动升级需要设为true
    /*autoMigrations = [
        AutoMigration(from = 1, to = 2),
        AutoMigration(from = 2, to = 3),
        AutoMigration(from = 3, to = 4),
        AutoMigration(from = 4, to = 5)
    ]*/
)
@TypeConverters(TypeConvert::class)
abstract class RoomManager : RoomDatabase() {

    abstract val violationDao: ViolationDao
    //abstract val userDao: UserDao?

    companion object {
        /**
         * fallbackToDestructiveMigration() 是 Android Room 持久化库中的一个方法，用于处理数据库版本升级时的容灾机制。
         * 其核心作用是：当数据库版本号增加，但未提供对应的迁移策略（Migration）时，Room 会直接删除旧数据库的所有表和数据，
         * 并重新创建新版本的空数据库，从而避免应用崩溃。开发阶段可用 fallbackToDestructiveMigration() 快速迭代，
         * 发布前必须替换为显式迁移策略，并通过 MigrationTestHelper 测试数据完整性
         */
        val instance: RoomManager by lazy {
            databaseBuilder(Utils.getApp().applicationContext, RoomManager::class.java, "clipboard.db")
                .allowMainThreadQueries()
                //.fallbackToDestructiveMigration()
                //.addMigrations(MIGRATION_1_2)
                .build()
        }
    }
}
