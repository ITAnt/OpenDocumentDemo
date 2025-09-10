# 🔍 AAR调试指南 - 追踪"正在加载..."问题

## 📋 新增的调试日志

新构建的AAR包含了详细的调试日志，可以帮助我们精确定位问题所在。

## 🎯 预期的完整日志流程

当您加载一个.docx文件时，应该看到以下完整的日志序列：

### 1. 文档加载开始
```
DocumentFragment: loadUri called with file:///path/to/file.docx
DocumentFragment: loadWithType called for METADATA with file filename.docx
```

### 2. 服务队列处理
```
LoaderServiceQueue: addToQueue called, service available: true
LoaderServiceQueue: Executing entry immediately
DocumentFragment: Calling service.loadWithType for METADATA
```

### 3. LoaderService处理
```
LoaderService: loadWithType called for METADATA with file filename.docx
LoaderService: loadAsync called successfully for METADATA
```

### 4. 元数据加载完成，切换到CORE
```
DocumentFragment: loadWithType called for CORE with file filename.docx
LoaderServiceQueue: addToQueue called, service available: true
LoaderServiceQueue: Executing entry immediately
DocumentFragment: Calling service.loadWithType for CORE
LoaderService: loadWithType called for CORE with file filename.docx
LoaderService: loadAsync called successfully for CORE
```

### 5. CoreWrapper处理
```
CoreWrapper: Starting parse for /path/to/file.docx
CoreWrapper: parseNative completed with errorCode: 0
CoreWrapper: Generated 1 pages
```

### 6. PageView处理
```
PageView: Received HTML diff, length: 1234
```

## 🚨 问题诊断

根据您看到的日志，可以判断问题出现在哪个阶段：

### 情况1: 没有任何日志
**问题**: DocumentFragment.loadUri() 没有被调用
**可能原因**: 
- AAR集成问题
- Activity/Fragment初始化问题
- 文件URI传递问题

### 情况2: 只有DocumentFragment日志
```
DocumentFragment: loadUri called with file:///path/to/file.docx
DocumentFragment: loadWithType called for METADATA with file filename.docx
```
**问题**: LoaderServiceQueue没有处理请求
**可能原因**: 
- LoaderService没有正确绑定
- 服务连接问题

### 情况3: 有LoaderServiceQueue日志但service为null
```
LoaderServiceQueue: addToQueue called, service available: false
LoaderServiceQueue: Adding entry to queue, current queue size: 1
```
**问题**: LoaderService没有连接
**可能原因**: 
- 服务绑定失败
- 在AAR环境中服务启动问题

### 情况4: 有LoaderService日志但没有CoreWrapper日志
```
LoaderService: loadWithType called for CORE with file filename.docx
LoaderService: loadAsync called successfully for CORE
```
**问题**: CoreLoader.loadSync() 没有被调用或卡住了
**可能原因**: 
- 后台线程问题
- CoreLoader初始化失败

### 情况5: 有CoreWrapper开始日志但没有完成日志
```
CoreWrapper: Starting parse for /path/to/file.docx
```
**问题**: parseNative() 调用卡住了
**这就是我们要解决的核心问题！**

## 🔧 针对性解决方案

基于您看到的日志，我们可以采取不同的解决策略：

### 如果是情况5（CoreWrapper卡住）
这是最常见的AAR问题。让我创建一个更激进的解决方案：

```java
// 在CoreLoader中添加超时机制
public void loadSync(Options options) {
    // 使用Future和超时来避免无限等待
    ExecutorService executor = Executors.newSingleThreadExecutor();
    Future<Void> future = executor.submit(() -> {
        // 原来的translate逻辑
        translate(options, result);
        return null;
    });
    
    try {
        future.get(10, TimeUnit.SECONDS); // 10秒超时
        callOnSuccess(result);
    } catch (TimeoutException e) {
        System.err.println("CoreLoader: Translation timeout, switching to fallback");
        callOnError(result, new RuntimeException("Translation timeout in AAR environment"));
    } catch (Exception e) {
        callOnError(result, e);
    } finally {
        executor.shutdown();
    }
}
```

## 📊 测试步骤

1. **使用新的AAR文件**
   - 位置: `app/build/outputs/aar/app-lite-release.aar`

2. **启用详细日志**
   ```java
   // 在您的Application或Activity中
   System.setProperty("debug.level", "VERBOSE");
   ```

3. **加载测试文档**
   - 使用一个简单的.docx文件
   - 观察logcat输出

4. **记录完整日志**
   - 从加载开始到结束的所有日志
   - 特别关注上述关键日志点

## 📞 反馈格式

请提供以下信息：

1. **看到的日志序列** (复制粘贴完整的相关日志)
2. **在哪个步骤停止了** (参考上面的情况分类)
3. **等待时间** (多长时间后确认卡住了)
4. **测试文件信息** (文件类型、大小)

这样我们就能精确定位问题并提供针对性的解决方案！

---

💡 **重要**: 这些调试日志只是为了定位问题，一旦问题解决，我们会移除这些日志以保持代码整洁。