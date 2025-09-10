# AAR Assets 调试指南

## 问题分析

根据我们的调查，AAR环境中odr对象不可用的问题已经定位到assets访问上。

### 关键发现

1. **Native库加载正常**：`libodr-core.so`可以正确加载
2. **Assets已打包**：AAR文件中包含了所有必要的assets文件，包括：
   - `odr.js` (18,713 bytes)
   - `odr_spreadsheet.js` (246 bytes)
   - `odr.css` (408 bytes)
   - `odr_spreadsheet.css` (374 bytes)

3. **问题根源**：在AAR环境中，assets提取过程可能失败

### 调试步骤

1. **检查assets访问**：
   ```java
   // 在CoreWrapper.initialize()中添加的调试代码会输出：
   // - Root assets列表
   // - Core assets列表
   // - ODR文件访问状态
   ```

2. **验证文件提取**：
   ```java
   // 检查提取后的文件是否存在：
   // - /data/data/[package]/files/assets/odrcore/odr.js
   // - /data/data/[package]/files/assets/odrcore/odr_spreadsheet.js
   ```

3. **测试HTML生成**：
   ```java
   // CoreLoader会输出：
   // - HTTP模式 vs 文件模式
   // - 生成的页面数量
   // - 页面URL/文件路径
   ```

### 可能的解决方案

如果assets提取失败，可以考虑：

1. **强制重新提取**：删除已存在的assets目录，强制重新提取
2. **使用HTTP模式**：确保HTTP服务器正常启动
3. **Fallback机制**：在assets不可用时提供替代方案

### 测试方法

1. 运行修改后的代码
2. 查看logcat输出中的"CoreWrapper:"标签
3. 确认assets是否正确提取
4. 检查odr.js文件是否存在且大小正确

### 预期输出

正常情况下应该看到：
```
CoreWrapper: ✓ odr.js found (18713 bytes) - odr object should be available
CoreWrapper: ✓ odr_spreadsheet.js found (246 bytes)
```

如果看到错误信息，说明assets提取失败，这就是odr对象不可用的根本原因。