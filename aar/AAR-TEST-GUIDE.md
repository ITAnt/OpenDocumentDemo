# 🧪 AAR测试指南 - "正在加载..."问题修复验证

## 📋 测试准备

### 1. 使用新构建的AAR
- 文件位置: `app/build/outputs/aar/app-lite-release.aar` 或 `app-pro-release.aar`
- 替换您项目中的旧AAR文件

### 2. 启用WebView调试（推荐）
```java
if (BuildConfig.DEBUG) {
    WebView.setWebContentsDebuggingEnabled(true);
}
```

## 🔍 预期的日志输出

### ✅ 正常情况（修复后）
当您加载.docx文件时，应该看到类似这样的日志：

```
LoaderService: loadWithType called for CORE with file 会议结论.docx
CoreWrapper: Starting parse for /path/to/file.docx
CoreWrapper: parseNative completed with errorCode: 0
CoreWrapper: Generated 1 pages
PageView: Received HTML diff, length: 1234
```

### ⚠️ AAR环境问题（会自动处理）
如果在AAR环境中遇到问题，会看到：

```
LoaderService: loadWithType called for CORE with file 会议结论.docx
CoreWrapper: Starting parse for /path/to/file.docx
CoreWrapper: No pages generated - this may cause odr object to be missing
PageView: HTML request timeout - odr object may not be available in AAR environment
PageView: Received HTML diff, length: 0
PageView: Empty HTML diff received - this is expected in AAR environment
```

## 🎯 测试步骤

### 1. 基本功能测试
```java
// 在您的Activity中
PageView pageView = new PageView(this, null);
setContentView(pageView);

// 加载测试文档
Uri documentUri = Uri.parse("file:///path/to/test.docx");
// 使用您的加载逻辑...
```

### 2. 监控关键日志
重点关注以下日志标签：
- `LoaderService`
- `CoreWrapper` 
- `PageView`
- `WebViewController` (您的应用中的)

### 3. 验证修复效果

#### ✅ 修复成功的标志：
- **不再无限显示"正在加载..."**
- 5秒内有响应（成功或失败都可以）
- 看到 `PageView: Received HTML diff` 日志
- WebView显示内容或明确的错误信息

#### ❌ 仍有问题的标志：
- 超过5秒仍显示"正在加载..."
- 没有 `PageView: Received HTML diff` 日志
- 日志中断在 `CoreWrapper: Starting parse`

## 🔧 故障排除

### 问题1: 仍然卡在"正在加载..."
**可能原因**: 
- AAR集成问题
- WebView初始化问题
- 文件权限问题

**解决步骤**:
1. 检查是否使用了最新的AAR
2. 确认WebView已正确初始化
3. 验证文件路径和权限

### 问题2: 看到超时日志但没有内容
**这是正常的！** 在AAR环境中，如果native库不能正常工作，会显示空内容而不是无限加载。

**预期行为**:
```
PageView: HTML request timeout - odr object may not be available in AAR environment
PageView: Empty HTML diff received - this is expected in AAR environment
```

### 问题3: 想要显示更友好的错误信息
您可以在收到空HTML时显示自定义消息：

```java
pageView.requestHtml(new PageView.HtmlCallback() {
    @Override
    public void onHtml(String htmlDiff) {
        if (htmlDiff == null || htmlDiff.isEmpty()) {
            // 显示友好的错误信息
            showDocumentNotSupported();
        } else {
            // 显示文档内容
            displayDocument(htmlDiff);
        }
    }
});
```

## 📊 测试用例

### 测试用例1: .docx文件
- **文件**: 任何Word文档
- **预期**: 5秒内有响应，不会无限加载

### 测试用例2: .txt文件  
- **文件**: 纯文本文件
- **预期**: 正常显示内容

### 测试用例3: 不支持的文件
- **文件**: .exe或其他二进制文件
- **预期**: 快速失败，显示错误信息

## 🎉 成功标准

修复被认为成功，如果：

1. ✅ **响应时间**: 任何文件在5秒内都有响应
2. ✅ **不再卡死**: 不会无限显示"正在加载..."
3. ✅ **清晰日志**: 能看到详细的处理过程
4. ✅ **优雅降级**: 不支持的文件能优雅地失败

## 📞 报告问题

如果测试中发现问题，请提供：

1. **完整的logcat输出** (从加载开始到结束)
2. **测试文件类型和大小**
3. **Android版本和设备信息**
4. **集成方式** (AAR版本、依赖配置等)

---

💡 **重要提醒**: 这个修复的目标不是让所有文档都能完美显示，而是确保不会卡在"正在加载..."状态。在AAR环境中，某些高级功能可能不可用，这是正常的。