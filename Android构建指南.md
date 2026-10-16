# Android APK 构建指南

## 📱 构建 Android APK 的步骤

### 方法 1：使用 Android Studio（推荐）

#### 1. 安装 Android Studio
1. 下载 Android Studio：https://developer.android.com/studio
2. 运行安装程序
3. 首次启动时会自动下载 Android SDK

#### 2. 配置 Android SDK
Android Studio 会自动安装以下组件：
- Android SDK Platform
- Android SDK Build-Tools
- Android SDK Platform-Tools
- Android SDK Tools

#### 3. 设置环境变量
添加以下环境变量到系统：

```
ANDROID_HOME=C:\Users\你的用户名\AppData\Local\Android\Sdk
```

然后将以下路径添加到 PATH：
```
%ANDROID_HOME%\platform-tools
%ANDROID_HOME%\tools
%ANDROID_HOME%\tools\bin
```

#### 4. 接受 Android SDK 许可
打开命令行，运行：
```bash
flutter doctor --android-licenses
```
一路按 `y` 接受所有许可。

#### 5. 构建 APK
```bash
cd d:\book\vocab_app
flutter build apk --release
```

APK 文件会生成在：
```
build\app\outputs\flutter-apk\app-release.apk
```

---

### 方法 2：使用命令行工具（高级）

#### 1. 下载 Android Command Line Tools
1. 访问：https://developer.android.com/studio#command-tools
2. 下载 "Command line tools only"
3. 解压到：`C:\Android\cmdline-tools`

#### 2. 安装 SDK 组件
```bash
cd C:\Android\cmdline-tools\bin
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
```

#### 3. 设置环境变量（同上）

#### 4. 构建 APK（同上）

---

### 方法 3：在线构建服务（无需本地 Android 环境）

如果不想安装 Android Studio，可以使用在线构建服务：

#### 使用 Codemagic（推荐）
1. 访问：https://codemagic.io/
2. 连接你的 Git 仓库
3. 自动构建 APK
4. 下载构建好的 APK

#### 使用 GitHub Actions
1. 将项目推送到 GitHub
2. 配置 GitHub Actions 工作流
3. 自动构建并发布 APK

---

## 🚀 快速构建脚本

我已经为你准备了一个自动化脚本：`setup_android.ps1`

运行它会：
1. 检查 Android SDK 是否已安装
2. 设置环境变量
3. 接受许可
4. 构建 APK

使用方法：
```powershell
.\setup_android.ps1
```

---

## 📦 安装 APK 到手机

### 方法 1：通过 USB 连接
1. 在手机上启用"开发者选项"和"USB 调试"
2. 用 USB 线连接手机到电脑
3. 运行：
   ```bash
   flutter install
   ```

### 方法 2：直接传输 APK
1. 将 `app-release.apk` 复制到手机
2. 在手机上打开文件管理器
3. 点击 APK 文件安装
4. 如果提示"未知来源"，需要在设置中允许安装

---

## 🔐 签名 APK（发布到应用商店）

如果要发布到 Google Play，需要使用正式签名：

### 1. 生成密钥库
```bash
keytool -genkey -v -keystore C:\Users\你的用户名\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 2. 配置签名
创建文件：`android/key.properties`
```
storePassword=你的密码
keyPassword=你的密码
keyAlias=upload
storeFile=C:/Users/你的用户名/upload-keystore.jks
```

### 3. 修改 `android/app/build.gradle`
在 `android {` 之前添加：
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

在 `buildTypes {` 之前添加：
```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
```

修改 `release` 配置：
```gradle
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

### 4. 构建签名的 APK
```bash
flutter build apk --release
```

---

## ❓ 常见问题

### Q: 构建失败，提示 "Android SDK not found"
A: 确保已安装 Android Studio 并设置了 ANDROID_HOME 环境变量。

### Q: 构建很慢
A: 首次构建会下载大量依赖，需要耐心等待（可能需要 10-30 分钟）。

### Q: 手机无法安装 APK
A: 检查手机是否允许"安装未知来源的应用"。

### Q: 运行 `flutter doctor` 显示错误
A: 运行 `flutter doctor --android-licenses` 接受所有许可。

---

## 📊 预计时间

- **首次安装 Android Studio**：30-60 分钟
- **首次构建 APK**：10-30 分钟
- **后续构建**：2-5 分钟

---

## 💡 推荐方案

**如果你是新手**：
- 使用方法 1（Android Studio），最简单直接

**如果你只是想快速测试**：
- 使用 Web 版本（已经可用）
- 或者使用在线构建服务

**如果你要发布应用**：
- 必须使用签名的 APK
- 考虑使用 CI/CD 自动化构建

---

需要我帮你安装 Android Studio 吗？或者你想先用 Web 版本测试功能？
