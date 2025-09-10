# WebView调试指南 - "正在加载..."问题深度分析

## 🔍 问题现状

从最新的日志分析：

```
CoreLoader: hostFile generated 1 pages ✅
CoreLoader: Page 0 URL: http://localhost:29665/file/odr/document.html ✅
vri.reportDrawFinished ✅
```

**结论**: HTTP服务器和文档解析都正常，问题在于WebView中的JavaScript执行。

## 🎯 新增的调试机制

### 1. 页面加载完成时的自动检查
```java
// 在 PageView.onPageFinished() 中添加
loadUrl("javascript:" +
    "console.log('PageView: Page loaded, checking odr object...');" +
    "if (typeof odr !== 'undefined') {" +
    "  console.log('PageView: odr object exists');" +
    "} else {" +
    "  console.log('PageView: odr object is undefined');" +
    "}");
```

### 2. 主动页面状态检查
```java
// 新增 checkPageStatus() 方法
pageView.checkPageStatus(); // 在loadData后3秒调用
```

### 3. 增强的requestHtml调试
```java
// 在requestHtml中添加更详细的日志
console.log('PageView: typeof odr = ' + typeof odr);
console.error('PageView: Error stack: ' + e.stack);
```

## 📊 预期的调试输出

### 正常情况应该看到：
```
I/DocumentFragment: Loading URL: http://localhost:29665/file/odr/document.html
I/PageView: onPageFinished - http://localhost:29665/file/odr/document.html
I/chromium: [INFO:CONSOLE(0)] "PageView: Page loaded, checking odr object..."
I/chromium: [INFO:CONSOLE(0)] "PageView: odr object exists, type: object"
I/chromium: [INFO:CONSOLE(0)] "PageView: odr.generateDiff exists"
I/DocumentFragment: Checking page status after load...
I/chromium: [INFO:CONSOLE(0)] "PageView: Manual page status check"
I/chromium: [INFO:CONSOLE(0)] "PageView: Document ready state: complete"
I/chromium: [INFO:CONSOLE(0)] "PageView: typeof odr = object"
I/chromium: [INFO:CONSOLE(0)] "PageView: odr.generateDiff is available"
```

### 问题情况可能看到：
```
I/DocumentFragment: Loading URL: http://localhost:29665/file/odr/document.html
I/PageView: onPageFinished - http://localhost:29665/file/odr/document.html
I/chromium: [INFO:CONSOLE(0)] "PageView: Page loaded, checking odr object..."
I/chromium: [INFO:CONSOLE(0)] "PageView: odr object is undefined"  ❌
I/DocumentFragment: Checking page status after load...
I/chromium: [INFO:CONSOLE(0)] "PageView: Manual page status check"
I/chromium: [INFO:CONSOLE(0)] "PageView: Document ready state: complete"
I/chromium: [INFO:CONSOLE(0)] "PageView: typeof odr = undefined"  ❌
I/chromium: [INFO:CONSOLE(0)] "PageView: Found 0 script tags"  ❌
```

## 🔧 可能的问题和解决方案

### 问题1: odr.js文件没有加载
**症状**: `typeof odr = undefined` 且 `Found 0 script tags`
**原因**: HTTP服务器返回的HTML中没有包含odr.js脚本
**解决**: 检查HTTP服务器的HTML模板

### 问题2: odr.js加载但对象未初始化
**症状**: `Found X script tags` 但 `typeof odr = undefined`
**原因**: JavaScript执行错误或初始化失败
**解决**: 检查JavaScript控制台错误

### 问题3: odr对象存在但generateDiff缺失
**症状**: `typeof odr = object` 但 `odr.generateDiff is NOT available`
**原因**: odr对象不完整或版本不匹配
**解决**: 检查odr.js文件完整性

### 问题4: 网络连接问题
**症状**: `onPageFinished` 不被调用或很晚才调用
**原因**: HTTP服务器连接问题
**解决**: 检查localhost:29665连接

## 🛠️ 调试步骤

### 1. 启用WebView调试
```java
if (BuildConfig.DEBUG) {
    WebView.setWebContentsDebuggingEnabled(true);
}
```

### 2. 使用Chrome DevTools
1. 在Chrome中打开 `chrome://inspect`
2. 找到你的应用WebView
3. 点击"inspect"
4. 查看Console和Network标签

### 3. 检查HTTP响应
```bash
# 如果可能，直接访问URL
curl http://localhost:29665/file/odr/document.html
```

### 4. 监控关键日志
重点关注这些日志标签：
- `DocumentFragment`
- `PageView`
- `chromium` (JavaScript控制台输出)

## 🎯 下一步行动

1. **运行新的调试版本**
2. **收集完整的日志输出**
3. **特别关注JavaScript控制台消息**
4. **确定odr对象的确切状态**

## 📋 日志收集清单

请收集以下日志：
- [ ] `DocumentFragment: Loading URL:` 
- [ ] `PageView: onPageFinished`
- [ ] `PageView: Page loaded, checking odr object...`
- [ ] `PageView: typeof odr = ?`
- [ ] `PageView: Manual page status check`
- [ ] `PageView: Document ready state: ?`
- [ ] `PageView: Found X script tags`
- [ ] 任何JavaScript错误消息

## 💡 临时解决方案

如果odr对象确实不可用，可以考虑：

1. **显示原始HTML**: 直接显示HTTP服务器返回的HTML
2. **降级到文件模式**: 禁用HTTP模式，使用本地文件
3. **用户友好提示**: 显示"此文档需要特殊支持"消息

这个调试版本将帮助我们准确定位问题是在HTTP服务器、HTML内容、JavaScript加载还是odr对象初始化阶段。