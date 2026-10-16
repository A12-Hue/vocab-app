# 📚 词汇学习 App - 项目总览

## ✅ 项目状态：代码已完成

所有代码已经写好，可以直接使用！

## 📁 项目位置

```
d:\book\vocab_app\
```

## 🎯 功能清单

✅ 词元（分组）管理：新建、删除词元  
✅ 单词管理：添加单词、选择词性、自定义释义、删除单词  
✅ 刷题模式：英文单词四选一中文释义  
✅ 错题本：自动记录答错的单词  
✅ 本地存储：使用 Hive 数据库，数据存本地  
✅ 深色主题：现代化 UI 设计  

## 📂 项目结构

```
vocab_app/
├── lib/                          # 源代码
│   ├── main.dart                 # 应用入口
│   ├── models.dart               # 数据模型（词元、单词、错题）
│   └── screens/                  # 界面
│       ├── home_screen.dart      # 首页（词元列表）
│       ├── group_detail_screen.dart  # 词元详情（单词列表）
│       ├── quiz_screen.dart      # 刷题模式
│       └── error_book_screen.dart    # 错题本
├── android/                      # Android 配置
├── ios/                          # iOS 配置
├── pubspec.yaml                  # 依赖配置
├── README.md                     # 详细文档
├── INSTALL.md                    # 安装指南
├── USER_GUIDE.md                 # 使用指南
├── install.ps1                   # 自动安装脚本 ⭐
├── run.ps1                       # 快速运行脚本
└── build_apk.ps1                 # 打包 APK 脚本
```

## 🚀 快速开始（3 个步骤）

### 第 1 步：安装 Flutter

**方式 1：使用自动脚本（推荐）**

1. 双击运行：`d:\book\vocab_app\install.ps1`
2. 按照提示安装 Flutter（需要手动下载 SDK）

**方式 2：手动安装**

详细步骤请查看：`INSTALL.md`

简要步骤：
1. 下载 Flutter：https://mirrors.tuna.tsinghua.edu.cn/flutter/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip
2. 解压到 `C:\flutter`
3. 添加环境变量：`C:\flutter\bin` 到 Path
4. 配置国内镜像（环境变量）：
   - `PUB_HOSTED_URL=https://pub.flutter-io.cn`
   - `FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn`

### 第 2 步：初始化项目

打开 PowerShell，执行：

```powershell
cd d:\book\vocab_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

或者直接运行：`install.ps1`（会自动执行）

### 第 3 步：运行或打包

**运行项目（需要连接手机或模拟器）：**
```powershell
flutter run
```
或双击：`run.ps1`

**打包 Android APK：**
```powershell
flutter build apk --release
```
或双击：`build_apk.ps1`

生成的 APK：`build\app\outputs\flutter-apk\app-release.apk`

**打包 iOS（需要 Mac + Xcode）：**
```bash
flutter build ios --release
open ios/Runner.xcworkspace
```

## 💻 技术栈

- **框架**：Flutter 3.24+
- **语言**：Dart
- **数据库**：Hive（轻量级本地 NoSQL）
- **UI**：Material Design 3（深色主题）
- **状态管理**：StatefulWidget + ValueListenableBuilder

## 📱 应用截图预览

应用包含 4 个主要界面：

1. **首页**：词元列表，显示所有词组
2. **词元详情**：单词列表，显示该词组的所有单词
3. **刷题模式**：四选一答题界面
4. **错题本**：显示所有答错的单词

## 📖 文档索引

- **README.md** - 完整技术文档和安装说明
- **INSTALL.md** - 详细的 Flutter 安装指南
- **USER_GUIDE.md** - 应用使用教程
- **PROJECT_OVERVIEW.md**（本文件）- 项目总览

## ⚡ 快速命令参考

```powershell
# 检查 Flutter 安装
flutter doctor

# 进入项目目录
cd d:\book\vocab_app

# 获取依赖
flutter pub get

# 生成数据库代码
flutter pub run build_runner build --delete-conflicting-outputs

# 运行项目
flutter run

# 打包 Android APK
flutter build apk --release

# 打包 iOS
flutter build ios --release

# 清理项目
flutter clean
```

## 🔧 常见问题

### Flutter 命令找不到
重新打开一个新的终端窗口

### 依赖下载很慢
确保配置了国内镜像环境变量

### 运行时报错 "models.g.dart not found"
执行：`flutter pub run build_runner build --delete-conflicting-outputs`

### 想要修改应用名称
修改 `pubspec.yaml` 中的 `name` 和 `android/app/src/main/AndroidManifest.xml` 中的 `android:label`

### 想要修改应用图标
替换 `android/app/src/main/res/mipmap-*/ic_launcher.png` 文件

### iOS 打包问题
必须在 Mac 上使用 Xcode 打包，Windows 无法打包 iOS

## 📞 需要帮助？

1. 查看 `INSTALL.md` - 安装问题
2. 查看 `USER_GUIDE.md` - 使用问题
3. 查看 `README.md` - 技术问题
4. 运行 `flutter doctor` - 检查环境

## 🎉 下一步

1. ✅ 安装 Flutter（如果还没有）
2. ✅ 运行 `install.ps1` 初始化项目
3. ✅ 运行 `flutter run` 或 `run.ps1` 启动应用
4. ✅ 开始使用，添加单词，开始学习！

---

**项目已完成，祝你学习顺利！** 🚀
