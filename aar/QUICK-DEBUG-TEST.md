# 🚀 快速调试测试 - 找出"正在加载..."的真正原因

## 📋 测试步骤

### 1. 使用新的调试版本
- 重新构建AAR并集成到你的应用中
- 确保包含了所有新的调试代码

### 2. 启用WebView调试（重要！）
```java
// 在你的应用中添加
if (BuildConfig.DEBUG) {
    WebView.setWebContentsDebuggingEnabled(true);
}
```

### 3. 加载一个测试文档
- 选择一个.docx文件
- 观察日志输出

## 🔍 关键日志检查点

### 检查点1: 文档解析
```
✅ 应该看到: CoreLoader: hostFile generated 1 pages
✅ 应该看到: CoreLoader: Page 0 URL: http://localhost:29665/file/odr/document.html
```

### 检查点2: WebView加载
```
✅ 应该看到: DocumentFragment: Loading URL: http://localhost:29665/...
✅ 应该看到: PageView: onPageFinished - http://localhost:29665/...
```

### 检查点3: JavaScript状态（关键！）
```
🔍 查找这些日志:
I/chromium: [INFO:CONSOLE(0)] "PageView: Page loaded, checking odr object..."
I/chromium: [INFO:CONSOLE(0)] "PageView: typeof odr = ?"

✅ 如果看到: "PageView: typeof odr = object" → odr对象存在
❌ 如果看到: "PageView: typeof odr = undefined" → odr对象缺失
```

### 检查点4: 页面内容分析
```
🔍 查找这些日志:
I/chromium: [INFO:CONSOLE(0)] "PageView: Document ready state: complete"
I/chromium: [INFO:CONSOLE(0)] "PageView: Document body innerHTML length: X"
I/chromium: [INFO:CONSOLE(0)] "PageView: Found X script tags"

✅ 如果 innerHTML length > 1000 → 页面有内容
✅ 如果 Found > 0 script tags → JavaScript文件已加载
❌ 如果 innerHTML length < 100 → 页面几乎为空
❌ 如果 Found 0 script tags → 没有JavaScript文件
```

### 检查点5: 加载消息检测
```
🔍 查找这些日志:
I/chromium: [INFO:CONSOLE(0)] "PageView: Found loading message in element: ?"
I/chromium: [INFO:CONSOLE(0)] "PageView: Loading message text: ?"

❌ 如果找到loading message → 页面确实显示"正在加载"
✅ 如果没找到 → 页面显示其他内容
```

## 🎯 问题诊断矩阵

| 症状 | 可能原因 | 解决方案 |
|------|----------|----------|
| `typeof odr = undefined` + `Found 0 script tags` | odr.js未加载 | 检查HTTP服务器HTML模板 |
| `typeof odr = undefined` + `Found > 0 script tags` | JavaScript执行错误 | 检查控制台错误 |
| `typeof odr = object` + `generateDiff NOT available` | odr对象不完整 | 检查odr.js版本 |
| `innerHTML length < 100` | HTTP服务器返回空页面 | 检查服务器配置 |
| `Found loading message` | 页面显示加载中 | 这就是问题所在！ |

## 🛠️ 基于结果的行动计划

### 如果 odr 对象不存在
```java
// 临时解决方案：显示原始HTML
webView.loadUrl(documentUrl); // 直接显示，不等待odr
```

### 如果 odr 对象存在但有问题
```java
// 尝试手动调用
webView.evaluateJavascript("odr.generateDiff()", new ValueCallback<String>() {
    @Override
    public void onReceiveValue(String value) {
        // 处理结果
    }
});
```

### 如果页面确实显示"正在加载"
```java
// 这说明odr对象在等待某些条件
// 可能需要触发某个事件或等待某个状态
```

## 📞 报告格式

请提供以下信息：

1. **检查点1结果**: CoreLoader日志 ✅/❌
2. **检查点2结果**: WebView加载日志 ✅/❌  
3. **检查点3结果**: `typeof odr = ?`
4. **检查点4结果**: `innerHTML length = ?`, `script tags = ?`
5. **检查点5结果**: 是否找到loading message ✅/❌
6. **完整的chromium日志**: 所有JavaScript控制台输出

## 💡 预期结果

这个测试将帮助我们确定：
- ✅ HTTP服务器是否正常工作
- ✅ HTML页面是否正确加载
- ✅ JavaScript文件是否包含在页面中
- ✅ odr对象是否正确初始化
- ✅ 页面是否真的显示"正在加载"消息

基于这些信息，我们就能准确定位问题并提供针对性的解决方案。