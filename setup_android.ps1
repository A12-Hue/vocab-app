# Android 构建环境自动设置脚本
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   词汇学习应用 - Android 构建助手" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Android Studio 是否已安装
Write-Host "[1/4] 检查 Android Studio..." -ForegroundColor Yellow

$androidStudioPath = "C:\Program Files\Android\Android Studio"
$androidSdkPath = "$env:LOCALAPPDATA\Android\Sdk"

if (Test-Path $androidStudioPath) {
    Write-Host "[OK] Android Studio 已安装" -ForegroundColor Green
} else {
    Write-Host "[X] 未找到 Android Studio" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先下载并安装 Android Studio:" -ForegroundColor Yellow
    Write-Host "https://developer.android.com/studio" -ForegroundColor Cyan
    Write-Host ""
    Start-Process "https://developer.android.com/studio"
    Write-Host "按任意键退出..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

# 检查 Android SDK
Write-Host ""
Write-Host "[2/4] 检查 Android SDK..." -ForegroundColor Yellow

if (Test-Path $androidSdkPath) {
    Write-Host "[OK] Android SDK: $androidSdkPath" -ForegroundColor Green
} else {
    Write-Host "[X] 未找到 Android SDK" -ForegroundColor Red
    Write-Host "请启动 Android Studio 让它自动下载 SDK" -ForegroundColor Yellow
    Write-Host "按任意键退出..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

# 检查环境变量
Write-Host ""
Write-Host "[3/4] 检查环境变量..." -ForegroundColor Yellow

$currentAndroidHome = [System.Environment]::GetEnvironmentVariable("ANDROID_HOME", "User")

if ($currentAndroidHome -eq $androidSdkPath) {
    Write-Host "[OK] ANDROID_HOME 已正确设置" -ForegroundColor Green
} else {
    Write-Host "设置 ANDROID_HOME..." -ForegroundColor Yellow
    [System.Environment]::SetEnvironmentVariable("ANDROID_HOME", $androidSdkPath, "User")
    $env:ANDROID_HOME = $androidSdkPath
    Write-Host "[OK] ANDROID_HOME 已设置" -ForegroundColor Green
}

# 检查 Flutter
Write-Host ""
Write-Host "[4/4] 检查 Flutter 环境..." -ForegroundColor Yellow
flutter doctor

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   环境检查完成!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "现在可以构建 APK:" -ForegroundColor Yellow
Write-Host "  cd d:\book\vocab_app" -ForegroundColor Cyan
Write-Host "  flutter build apk --release" -ForegroundColor Cyan
Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
