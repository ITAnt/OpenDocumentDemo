从版本 6 到 7 需要同时 **新增表** 和 **修改字段类型**，这涉及两次 schema 变更。以下是分步实现方案：


### **步骤 1：修改实体类**
更新 `Meeting` 实体类，将 `url` 字段改为 `boolean`，并新增 `Favorite` 实体类：
```java
@Entity(tableName = "meeting")
public class Meeting {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String title;
    // 版本 7：将 url 字段从 int 改为 boolean
    public boolean url;
}

@Entity(tableName = "favorite")
public class Favorite {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public int meetingId; // 关联 Meeting 表
    public long timestamp;
}
```


### **步骤 2：创建自定义 Migration**
使用 **临时表策略** 处理类型变更，并新增 `Favorite` 表：
```java
static final Migration MIGRATION_6_7 = new Migration(6, 7) {
    @Override
    public void migrate(SupportSQLiteDatabase database) {
        // 1. 创建临时表，使用新的 schema（url 为 boolean 类型）
        database.execSQL(
            "CREATE TABLE meeting_temp (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "title TEXT, " +
            "url INTEGER)" // SQLite 中没有 boolean 类型，使用 INTEGER (0/1) 表示
        );

        // 2. 从旧表复制数据到临时表（注意类型转换）
        // 将 int 值转换为 boolean（非零值 → true，零值 → false）
        database.execSQL(
            "INSERT INTO meeting_temp (id, title, url) " +
            "SELECT id, title, CASE WHEN url != 0 THEN 1 ELSE 0 END FROM meeting"
        );

        // 3. 删除旧表
        database.execSQL("DROP TABLE meeting");

        // 4. 重命名临时表为原表名
        database.execSQL("ALTER TABLE meeting_temp RENAME TO meeting");

        // 5. 创建 Favorite 表
        database.execSQL(
            "CREATE TABLE favorite (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "meetingId INTEGER, " +
            "timestamp INTEGER, " +
            "FOREIGN KEY(meetingId) REFERENCES meeting(id))"
        );
    }
};
```


### **步骤 3：添加 Migration 到数据库构建器**
```java
Room.databaseBuilder(context, AppDatabase.class, "app-database")
    .addMigrations(MIGRATION_5_6, MIGRATION_6_7) // 添加所有自定义 Migration
    .build();
```


### **关键注意事项**
1. **布尔值存储方式**：
    - SQLite 没有原生 `BOOLEAN` 类型，使用 `INTEGER`（0 表示 `false`，非零值表示 `true`）。
    - 代码中通过 `CASE WHEN url != 0 THEN 1 ELSE 0` 将原 `int` 值转换为布尔逻辑。

2. **数据映射规则**：
    - 原 `url` 字段中的 **非零值**（如 `1`, `2`, `-1`）会被转换为 `true`（SQLite 中存储为 `1`）。
    - **零值**（`0`）会被转换为 `false`（SQLite 中存储为 `0`）。

3. **外键约束**：
   `Favorite` 表添加了对 `Meeting` 表的外键约束，确保数据一致性。


### **完整代码示例**
```java
@Database(
    version = 7,
    entities = {Meeting.class, User.class, Record.class, Favorite.class},
    autoMigrations = {
        @AutoMigration(from = 1, to = 2),
        @AutoMigration(from = 2, to = 3),
        @AutoMigration(from = 3, to = 4),
        @AutoMigration(from = 4, to = 5)
    }
)
public abstract class AppDatabase extends RoomDatabase {
    public abstract MeetingDao meetingDao();
    public abstract UserDao userDao();
    public abstract RecordDao recordDao();
    public abstract FavoriteDao favoriteDao();

    // 版本 5→6 的 Migration（url 从 TEXT → INTEGER）
    static final Migration MIGRATION_5_6 = new Migration(5, 6) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("CREATE TABLE meeting_temp (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, url INTEGER)");
            database.execSQL("INSERT INTO meeting_temp (id, title, url) SELECT id, title, CAST(url AS INTEGER) FROM meeting");
            database.execSQL("DROP TABLE meeting");
            database.execSQL("ALTER TABLE meeting_temp RENAME TO meeting");
        }
    };

    // 版本 6→7 的 Migration（url 从 INTEGER → BOOLEAN，新增 Favorite 表）
    static final Migration MIGRATION_6_7 = new Migration(6, 7) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("CREATE TABLE meeting_temp (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, url INTEGER)");
            database.execSQL("INSERT INTO meeting_temp (id, title, url) SELECT id, title, CASE WHEN url != 0 THEN 1 ELSE 0 END FROM meeting");
            database.execSQL("DROP TABLE meeting");
            database.execSQL("ALTER TABLE meeting_temp RENAME TO meeting");
            database.execSQL("CREATE TABLE favorite (id INTEGER PRIMARY KEY AUTOINCREMENT, meetingId INTEGER, timestamp INTEGER, FOREIGN KEY(meetingId) REFERENCES meeting(id))");
        }
    };
}

// 构建数据库时添加所有 Migration
AppDatabase db = Room.databaseBuilder(context, AppDatabase.class, "app-database")
    .addMigrations(MIGRATION_5_6, MIGRATION_6_7)
    .build();
```


### **测试建议**
1. **数据验证**：升级后检查 `Meeting` 表的 `url` 字段是否正确映射为布尔值。
2. **跨版本升级测试**：确保从任意旧版本（如 1、3、5）都能顺利升级到 7。
3. **数据完整性**：验证 `Favorite` 表与 `Meeting` 表的关联关系是否正常。

通过这种方式，你可以安全地处理字段类型变更和新增表，同时保持数据库的向后兼容性。

如果从7到8只是简单的增加一个表，可以加上`AutoMigration(from = 7, to = 8) // 新增自动迁移`，记得修改version！