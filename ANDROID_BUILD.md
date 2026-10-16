# Android 打包说明

## 📱 应用信息
- **应用名称**: 词汇学习
- **包名**: com.vocabapp.learning
- **最低 Android 版本**: Android 5.0 (API 21)
- **目标 Android 版本**: Android 14 (API 34)

## ✨ 最新功能更新

### 1. 词性新增"短语"选项
在添加单词时，词性选择现在包含：
- 名词
- 动词
- 形容词
- 副词
- **短语** ⭐ (新增)
- 介词
- 连词
- 代词
- 感叹词

### 2. 智能刷题选项系统
刷题时的4个选项现在使用智能混合策略：
- **优先使用用户词汇**：从你的词元中选择干扰选项
- **自动补充默认选项**：当词汇量不足时，从300个预设常见词汇中补充
- **避免重复**：确保4个选项不重复
- **智能打乱**：每次刷题选项顺序随机

## 🚀 打包步骤

### 方法 1：直接安装到手机 (推荐)

1. **连接手机**
   - 用 USB 数据线连接 Android 手机到电脑
   - 在手机上开启"开发者选项"和"USB 调试"

2. **检查连接**
   ```bash
   flutter devices
   ```
   应该能看到你的手机设备

3. **直接安装运行**
   ```bash
   cd d:\book\vocab_app
   flutter run --release
   ```

### 方法 2：生成 APK 安装包

1. **构建 APK**
   ```bash
   cd d:\book\vocab_app
   flutter build apk --release
   ```

2. **找到 APK 文件**
   APK 文件位于：
   ```
   d:\book\vocab_app\build\app\outputs\flutter-apk\app-release.apk
   ```

3. **安装到手机**
   - 将 APK 文件传输到手机
   - 在手机上点击 APK 文件安装

### 方法 3：生成 App Bundle (上架应用商店)

如果你想上架 Google Play：
```bash
flutter build appbundle --release
```

生成的文件位于：
```
d:\book\vocab_app\build\app\outputs\bundle\release\app-release.aab
```

## 📋 Android 开发者选项开启方法

1. 打开手机**设置**
2. 找到**关于手机**
3. 连续点击**版本号** 7次
4. 返回设置，找到**开发者选项**
5. 开启**USB 调试**

## 🔧 常见问题

### 问题：找不到设备
**解决**：
- 确保手机已开启 USB 调试
- 更换 USB 数据线或 USB 接口
- 在手机上允许"USB 调试"授权弹窗

### 问题：构建失败
**解决**：
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### 问题：应用闪退
**解决**：
- 确保手机 Android 版本 ≥ 5.0
- 卸载旧版本后重新安装

## 📊 应用大小
- APK 大小：约 20-30 MB
- 安装后大小：约 40-50 MB

## 🎯 测试功能清单

安装后建议测试：
- ✅ 创建词元
- ✅ 添加单词（测试新增的"短语"词性）
- ✅ 刷题模式（检查选项是否正常显示）
- ✅ 错题本记录
- ✅ 删除词元和单词
- ✅ 应用关闭后数据是否保存

## 💡 优化建议

如果你想进一步优化：
1. **减小应用体积**
   ```bash
   flutter build apk --release --split-per-abi
   ```
   会生成针对不同 CPU 架构的独立 APK

2. **混淆代码**（提高安全性）
   - 编辑 `android/app/build.gradle`
   - 在 `release` 配置中添加 `minifyEnabled true`

3. **自定义图标**
   - 替换 `android/app/src/main/res/mipmap-*/ic_launcher.png`

## 🎉 完成！

现在你就可以在 Android 手机上使用词汇学习 APP 了！
