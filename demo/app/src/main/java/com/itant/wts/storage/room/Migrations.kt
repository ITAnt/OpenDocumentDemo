package com.itant.wts.storage.room

import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase

/**
 * 版本从 1 升级到 2 的迁移，添加了新列 meetingUrl
 */
val MIGRATION_1_2 = object : Migration(1, 2) {
    override fun migrate(db: SupportSQLiteDatabase) {
        // 添加新列（SQLite 会自动为旧数据填充 null 或默认值）
        db.execSQL("ALTER TABLE t_meeting_record ADD COLUMN meetingUrl TEXT")
    }
}