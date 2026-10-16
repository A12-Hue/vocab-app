# 词汇学习 App

一个基于 Flutter 的词汇学习应用，支持词元管理、刷题模式和错题本功能。

## 功能特性

- ✅ **词元管理**：创建和删除词元（单词分组）
- ✅ **单词管理**：添加单词、选择词性、自定义中文释义、删除单词
- ✅ **刷题模式**：显示英文单词，四选一选择中文释义
- ✅ **错题本**：自动记录答错的单词，可查看和清空
- ✅ **本地存储**：使用 Hive 数据库，所有数据存储在本地，无需服务器

## 安装步骤

### 1. 安装 Flutter SDK

**Windows 系统：**

1. 下载 Flutter SDK：
   - 官方源：https://flutter.dev/docs/get-started/install/windows
   - 国内镜像（推荐）：https://mirrors.tuna.tsinghua.edu.cn/flutter/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip

2. 解压到 `C:\flutter`（或其他目录）

3. 配置环境变量：
   - 打开"系统属性" -> "高级" -> "环境变量"
   - 在"用户变量"中找到 Path，点击"编辑"
   - 添加：`C:\flutter\bin`
   - 点击"确定"保存

4. 配置国内镜像（加速下载）：
   在"环境变量"中添加：
   ```
   PUB_HOSTED_URL=https://pub.flutter-io.cn
   FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
   ```

5. 打开新的命令行窗口，运行：
   ```
   flutter doctor
   ```

### 2. 运行项目

1. 进入项目目录：
   ```
   cd d:\book\vocab_app
   ```

2. 获取依赖：
   ```
   flutter pub get
   ```

3. 生成 Hive 模型代码：
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. 运行项目（连接手机或使用模拟器）：
   ```
   flutter run
   ```

### 3. 打包 iOS App（需要 Mac）

**在 Mac 上操作：**

1. 安装 Xcode（从 App Store 安装）

2. 将项目文件夹复制到 Mac

3. 打开终端，进入项目目录：
   ```
   cd /path/to/vocab_app
   ```

4. 安装依赖：
   ```
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. 构建 iOS：
   ```
   flutter build ios --release
   ```

6. 打开 Xcode：
   ```
   open ios/Runner.xcworkspace
   ```

7. 在 Xcode 中：
   - 连接你的 iPhone
   - 选择你的设备
   - 点击"Product" -> "Archive"
   - 导出 IPA 文件或直接安装到设备

### 4. 打包 Android App（Windows 也可以）

1. 确保安装了 Android Studio 和 Android SDK

2. 运行：
   ```
   flutter build apk --release
   ```

3. 生成的 APK 文件位置：
   ```
   build\app\outputs\flutter-apk\app-release.apk
   ```

4. 将 APK 传到手机安装即可

## 项目结构

```
vocab_app/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── models.dart            # 数据模型
│   ├── models.g.dart          # Hive 自动生成的适配器
│   └── screens/
│       ├── home_screen.dart           # 首页（词元列表）
│       ├── group_detail_screen.dart   # 词元详情（单词列表）
│       ├── quiz_screen.dart           # 刷题模式
│       └── error_book_screen.dart     # 错题本
├── android/                   # Android 配置
├── ios/                       # iOS 配置（需要在 Mac 上配置）
├── pubspec.yaml              # 依赖配置
└── README.md                 # 本文件
```

## 使用说明

1. **创建词元**：点击首页右下角"新建词元"按钮
2. **添加单词**：进入词元，点击右下角"+"按钮，填写英文、词性、中文释义
3. **开始刷题**：点击顶部"刷题"图标，或点击某个词元的"播放"按钮
4. **查看错题**：点击顶部"错题本"图标

## 常见问题

### Flutter Doctor 报错

运行 `flutter doctor` 后，按提示安装缺失的工具：
- Android toolchain：安装 Android Studio
- Xcode（仅 Mac）：从 App Store 安装

### 依赖下载慢

确保已配置国内镜像（见安装步骤第 1.4 步）

### iOS 打包失败

- 确保使用 Mac 系统
- 确保 Xcode 已安装
- 在 Xcode 中配置签名证书

## 技术栈

- **框架**：Flutter 3.24+
- **语言**：Dart
- **数据库**：Hive（本地 NoSQL）
- **状态管理**：StatefulWidget + ValueListenableBuilder

## 许可

本项目仅供学习使用。
