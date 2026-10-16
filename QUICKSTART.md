# ⚡ 5 分钟快速上手指南

## 🎯 目标
让你在 5 分钟内了解如何使用这个词汇学习 App

## 📍 你现在的位置
✅ 代码已完成：`d:\book\vocab_app\`  
❌ Flutter 未安装：需要手动下载安装  

## 🚀 三步走

### ⭐ 第一步：安装 Flutter（首次必须）

**只需做一次！以后不用重复**

1️⃣ **下载 Flutter SDK**（点击链接下载）  
👉 https://mirrors.tuna.tsinghua.edu.cn/flutter/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip

2️⃣ **解压到 C 盘**  
将下载的 zip 文件解压到 `C:\`，得到 `C:\flutter` 文件夹

3️⃣ **设置环境变量**
- 按键盘 `Win + R`
- 输入 `sysdm.cpl` 回车
- 点"高级"→"环境变量"
- 找到"用户变量"的 `Path`，双击
- 点"新建"，输入：`C:\flutter\bin`
- 再新建两个变量：
  - 变量名：`PUB_HOSTED_URL`，值：`https://pub.flutter-io.cn`
  - 变量名：`FLUTTER_STORAGE_BASE_URL`，值：`https://storage.flutter-io.cn`
- 点"确定"保存

4️⃣ **验证安装**
- 打开**新的** PowerShell（一定要新开！）
- 输入：`flutter --version`
- 看到版本号就成功了！

---

### ⭐ 第二步：初始化项目

**双击运行：`d:\book\vocab_app\install.ps1`**

这个脚本会自动：
- ✅ 检查 Flutter 是否安装
- ✅ 下载项目依赖
- ✅ 生成数据库代码
- ✅ 检查开发环境

如果不想用脚本，也可以手动执行：
```powershell
cd d:\book\vocab_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### ⭐ 第三步：运行或打包

#### 方式 1：在电脑上运行（需要 Android 模拟器）

1. 安装 Android Studio：https://developer.android.google.cn/studio
2. 启动 Android 模拟器
3. 双击运行：`d:\book\vocab_app\run.ps1`

#### 方式 2：打包成 APK 安装到手机 ⭐推荐

1. 双击运行：`d:\book\vocab_app\build_apk.ps1`
2. 等待几分钟，会自动打开文件夹
3. 将 `app-release.apk` 传到 Android 手机
4. 在手机上安装 APK

#### 方式 3：打包 iOS（需要 Mac）

把整个 `vocab_app` 文件夹复制到 Mac，然后：
```bash
cd /path/to/vocab_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter build ios --release
open ios/Runner.xcworkspace
```

---

## 📱 开始使用 App

1. **新建词元**：首页点"新建词元"，输入名称（如：托福词汇）
2. **添加单词**：进入词元，点"+"，填写单词信息
3. **开始刷题**：点刷题图标，选择题答题
4. **查看错题**：点错题本图标，复习错题

---

## ❓ 遇到问题？

### Flutter 命令找不到
👉 关闭当前终端，**重新打开新的** PowerShell

### install.ps1 提示 Flutter 未安装
👉 确保完成了第一步，并重新打开终端

### 依赖下载很慢
👉 确保环境变量设置了国内镜像（第一步的 3️⃣）

### 想要在 iPhone 上用
👉 必须有 Mac 电脑和 Xcode，Windows 无法打包 iOS

---

## 📚 更多文档

- **INSTALL.md** - 详细安装教程
- **USER_GUIDE.md** - 详细使用教程
- **README.md** - 完整技术文档
- **PROJECT_OVERVIEW.md** - 项目总览

---

## ✅ 检查清单

安装前检查：
- [ ] 已下载 Flutter SDK
- [ ] 已解压到 C:\flutter
- [ ] 已设置环境变量（3 个）
- [ ] 打开新终端，`flutter --version` 有输出

运行前检查：
- [ ] 已运行 `install.ps1` 或手动执行初始化命令
- [ ] 看到"安装完成"提示

打包前检查：
- [ ] 已完成上述所有步骤
- [ ] `flutter doctor` 没有严重错误

---

**就这么简单！开始你的词汇学习之旅吧！** 🎉
