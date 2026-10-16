# Flutter 词汇学习 App - 快速安装指南

本指南将帮助你从零开始安装 Flutter 并运行项目。

## 第一步：安装 Flutter（Windows）

### 方法 1：手动下载安装（推荐）

1. **下载 Flutter SDK**
   
   打开浏览器，访问以下链接下载（选其中一个）：
   
   - **国内镜像（快）**：https://mirrors.tuna.tsinghua.edu.cn/flutter/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip
   - 官方源：https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip

2. **解压文件**
   
   将下载的 zip 文件解压到 `C:\` 盘根目录，得到 `C:\flutter` 文件夹

3. **配置环境变量**

   - 按 `Win + R`，输入 `sysdm.cpl`，回车
   - 点击"高级"标签 -> "环境变量"
   - 在"用户变量"区域，找到 `Path`，双击
   - 点击"新建"，输入：`C:\flutter\bin`
   - 点击"确定"保存所有窗口

4. **配置国内镜像（重要！）**

   - 在"环境变量"窗口，点击"用户变量"下的"新建"
   - 变量名：`PUB_HOSTED_URL`
   - 变量值：`https://pub.flutter-io.cn`
   - 再次点击"新建"
   - 变量名：`FLUTTER_STORAGE_BASE_URL`
   - 变量值：`https://storage.flutter-io.cn`

5. **验证安装**

   - 打开**新的** PowerShell 或命令提示符窗口
   - 输入：`flutter --version`
   - 如果显示版本信息，说明安装成功！

### 方法 2：使用 Git 克隆（需要先安装 Git）

```powershell
# 安装 Git（如果没有）
# 访问 https://git-scm.com/download/win 下载安装

# 克隆 Flutter（使用国内镜像）
cd C:\
git clone -b stable https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git flutter

# 然后按照方法 1 的第 3-5 步配置环境变量
```

## 第二步：安装 Android Studio（可选，如果要打包 Android）

1. 下载：https://developer.android.google.cn/studio
2. 安装，按默认选项即可
3. 首次启动，会自动下载 Android SDK
4. 打开 PowerShell，运行：
   ```
   flutter doctor --android-licenses
   ```
   一路输入 `y` 接受许可

## 第三步：运行项目

打开 PowerShell，执行：

```powershell
# 进入项目目录
cd d:\book\vocab_app

# 安装依赖
flutter pub get

# 生成数据库模型代码
flutter pub run build_runner build --delete-conflicting-outputs

# 检查环境
flutter doctor

# 连接手机或启动模拟器后，运行项目
flutter run
```

## 第四步：打包

### 打包 Android APK

```powershell
cd d:\book\vocab_app
flutter build apk --release
```

生成的 APK 在：`build\app\outputs\flutter-apk\app-release.apk`

### 打包 iOS（需要 Mac）

1. 将整个 `vocab_app` 文件夹复制到 Mac
2. 在 Mac 终端执行：
   ```bash
   cd /path/to/vocab_app
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   flutter build ios --release
   open ios/Runner.xcworkspace
   ```
3. 在 Xcode 中连接 iPhone，选择设备，点击运行

## 常见问题

### Q: flutter 命令找不到
A: 重新打开一个新的终端窗口，旧的窗口不会读取新的环境变量

### Q: 依赖下载很慢
A: 检查是否配置了国内镜像环境变量（第一步第 4 点）

### Q: flutter doctor 显示红叉
A: 根据提示安装对应工具。只要有绿勾，就能运行项目

### Q: 需要 iOS 真机测试
A: 必须使用 Mac + Xcode + 开发者账号

## 需要帮助？

项目目录：`d:\book\vocab_app`
详细文档：参考 `README.md`
