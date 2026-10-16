# Flutter 词汇学习 App - 自动安装脚本
# 使用方法：右键此文件，选择"使用 PowerShell 运行"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Flutter 词汇学习 App - 自动安装" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Flutter 是否已安装
Write-Host "[1/5] 检查 Flutter 安装状态..." -ForegroundColor Yellow
$flutterInstalled = $false
try {
    $flutterVersion = flutter --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Flutter 已安装" -ForegroundColor Green
        $flutterInstalled = $true
    }
} catch {
    Write-Host "✗ Flutter 未安装" -ForegroundColor Red
}

if (-not $flutterInstalled) {
    Write-Host ""
    Write-Host "需要手动安装 Flutter，请按照以下步骤操作：" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. 下载 Flutter SDK（推荐使用国内镜像）：" -ForegroundColor White
    Write-Host "   https://mirrors.tuna.tsinghua.edu.cn/flutter/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. 解压到 C:\flutter" -ForegroundColor White
    Write-Host ""
    Write-Host "3. 添加环境变量：" -ForegroundColor White
    Write-Host "   - 在系统 Path 中添加：C:\flutter\bin" -ForegroundColor Cyan
    Write-Host "   - 添加变量 PUB_HOSTED_URL=https://pub.flutter-io.cn" -ForegroundColor Cyan
    Write-Host "   - 添加变量 FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "4. 重新运行此脚本" -ForegroundColor White
    Write-Host ""
    Write-Host "详细安装指南请查看：INSTALL.md" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按回车键退出"
    exit
}

# 进入项目目录
Write-Host ""
Write-Host "[2/5] 进入项目目录..." -ForegroundColor Yellow
$projectPath = "d:\book\vocab_app"
if (Test-Path $projectPath) {
    Set-Location $projectPath
    Write-Host "✓ 已进入目录：$projectPath" -ForegroundColor Green
} else {
    Write-Host "✗ 项目目录不存在：$projectPath" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit
}

# 获取依赖
Write-Host ""
Write-Host "[3/5] 获取 Flutter 依赖（可能需要几分钟）..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 依赖获取成功" -ForegroundColor Green
} else {
    Write-Host "✗ 依赖获取失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit
}

# 生成 Hive 模型代码
Write-Host ""
Write-Host "[4/5] 生成数据库模型代码..." -ForegroundColor Yellow
flutter pub run build_runner build --delete-conflicting-outputs
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 模型代码生成成功" -ForegroundColor Green
} else {
    Write-Host "✗ 模型代码生成失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit
}

# 检查环境
Write-Host ""
Write-Host "[5/5] 检查 Flutter 环境..." -ForegroundColor Yellow
flutter doctor

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  安装完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "接下来的步骤：" -ForegroundColor Yellow
Write-Host ""
Write-Host "运行项目（需要连接手机或模拟器）：" -ForegroundColor White
Write-Host "  flutter run" -ForegroundColor Cyan
Write-Host ""
Write-Host "打包 Android APK：" -ForegroundColor White
Write-Host "  flutter build apk --release" -ForegroundColor Cyan
Write-Host "  生成位置：build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Gray
Write-Host ""
Write-Host "打包 iOS（需要 Mac + Xcode）：" -ForegroundColor White
Write-Host "  flutter build ios --release" -ForegroundColor Cyan
Write-Host ""

Read-Host "按回车键退出"
