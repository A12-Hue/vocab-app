# 词汇学习应用

一个现代化的词汇学习Flutter应用，支持词元管理、刷题模式和错题本功能。

## ✨ 功能特性

### 1. 词元（分组）管理
- ✅ 创建、编辑、删除词元分组
- ✅ 每个词元可包含多个单词
- ✅ 支持词性标注和自定义释义

### 2. 单词管理
- ✅ 在词元内新增单词
- ✅ 选择词性（名词、动词、形容词等）
- ✅ 自定义中文释义
- ✅ 删除单词

### 3. 刷题模式
- ✅ 显示英文单词
- ✅ 选择题形式选择中文释义
- ✅ 实时答题统计
- ✅ 答题进度显示
- ✅ 答题结果汇总

### 4. 错题本
- ✅ 自动记录答错的单词
- ✅ 显示正确答案和错误答案
- ✅ 记录答题时间
- ✅ 支持单独删除错题
- ✅ 一键清空所有错题

## 🎨 界面设计

- 采用现代化深色主题设计
- 流畅的动画效果和过渡
- 渐变色背景和阴影效果
- 底部导航栏设计
- 响应式布局

## 💾 数据存储

使用 **Hive** 本地数据库：
- ✅ 所有数据永久保存在手机本地
- ✅ 无需网络连接
- ✅ 不需要服务器
- ✅ 数据不会丢失（除非手动删除或卸载应用清除数据）

## 📱 平台支持

目前支持：**iOS**
也可以轻松扩展到 Android 平台

## 🚀 如何运行

### 前提条件
1. 安装 Flutter SDK
2. 安装 Xcode（用于 iOS 打包）
3. 配置 iOS 开发环境

### 安装依赖
```bash
cd vocab_app
flutter pub get
```

### 运行应用
```bash
# 连接 iOS 设备或启动模拟器
flutter devices

# 运行应用
flutter run
```

### 打包 iOS 应用
```bash
# 打包 IPA 文件
flutter build ios --release

# 或使用 Xcode 打开项目进行打包
open ios/Runner.xcworkspace
```

## 📂 项目结构

```
vocab_app/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── models.dart            # 数据模型
│   ├── screens/
│   │   ├── home_screen.dart   # 首页（词元列表）
│   │   ├── token_words_screen.dart  # 词元详情（单词列表）
│   │   ├── quiz_screen.dart   # 刷题界面
│   │   └── error_book_screen.dart   # 错题本
│   └── widgets/
│       └── gradient_button.dart     # 渐变按钮组件
├── pubspec.yaml               # 依赖配置
└── README_CN.md              # 中文说明文档
```

## 📊 数据模型

### Token（词元）
- `title`: 词元标题
- `words`: 包含的单词列表

### Word（单词）
- `english`: 英文单词
- `chineseMeaning`: 中文释义
- `partOfSpeech`: 词性

### ErrorRecord（错题记录）
- `english`: 英文单词
- `correctAnswer`: 正确答案
- `userAnswer`: 用户答案
- `wrongAt`: 答错时间

## 🎯 使用流程

1. **创建词元**：在首页点击"新建词元"按钮
2. **添加单词**：进入词元详情，点击"添加单词"按钮
3. **开始刷题**：点击词元卡片上的"开始刷题"按钮
4. **查看错题**：在底部导航栏切换到"错题本"

## 🔧 技术栈

- **框架**：Flutter
- **语言**：Dart
- **数据库**：Hive
- **UI**：Material Design + 自定义深色主题

## 📝 注意事项

1. 数据保存在本地，不会上传到云端
2. 卸载应用会清除所有数据（如需备份请先导出）
3. 首次运行需要初始化数据库
4. iOS 打包需要 Apple 开发者账号

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License
