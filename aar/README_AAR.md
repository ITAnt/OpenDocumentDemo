# OpenDocument.droid AAR 库使用指南

本文档说明如何将 OpenDocument.droid 项目编译为 AAR 库并在其他项目中使用。

## 构建 AAR 库

### 前提条件

- Android Studio
- JDK 8 或更高版本
- Gradle
- 已配置的 NDK

### 构建步骤

1. 克隆项目代码

```bash
git clone https://github.com/your-repo/OpenDocument.droid.git
cd OpenDocument.droid
```

2. 执行构建 AAR 任务

```bash
./gradlew buildAAR
```

构建完成后，AAR 文件将生成在项目根目录的 `output` 文件夹中。

## 在其他项目中使用 AAR 库

### 方法一：本地引用

1. 将生成的 AAR 文件复制到您的项目的 `libs` 目录下

2. 在项目级 `build.gradle` 文件中添加：

```groovy
allprojects {
    repositories {
        // 其他仓库...
        flatDir {
            dirs 'libs'
        }
    }
}
```

3. 在应用模块的 `build.gradle` 文件中添加依赖：

```groovy
dependencies {
    implementation(name: 'opendocument-reader-release', ext: 'aar')
    
    // 必要的依赖项
    implementation 'androidx.appcompat:appcompat:1.7.0'
    implementation 'androidx.core:core:1.13.1'
    // 根据需要添加其他依赖...
}
```

### 方法二：发布到本地 Maven 仓库

1. 发布到本地 Maven 仓库：

```bash
./gradlew publishToMavenLocal
```

2. 在项目级 `build.gradle` 文件中添加：

```groovy
allprojects {
    repositories {
        // 其他仓库...
        mavenLocal()
    }
}
```

3. 在应用模块的 `build.gradle` 文件中添加依赖：

```groovy
dependencies {
    implementation 'at.tomtasche.reader:opendocument-reader:1.0.0'
}
```

## 使用示例

```java
import at.tomtasche.reader.ui.DocumentFragment;

// 在您的 Activity 或 Fragment 中
DocumentFragment documentFragment = new DocumentFragment();
getSupportFragmentManager()
    .beginTransaction()
    .replace(R.id.container, documentFragment)
    .commit();

// 打开文档
documentFragment.openDocument(uri);
```

## 注意事项

- 该库支持的 ABI 架构为 `arm64-v8a` 和 `x86_64`
- 使用该库时，请确保您的应用也支持这些架构
- 如需支持其他架构，请修改 `build.gradle` 文件中的 `abiFilters` 配置

## 许可证

请参阅项目中的 LICENSE 文件。