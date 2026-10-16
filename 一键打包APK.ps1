# 一键打包 Android APK 脚本
# 自动下载并配置 Android SDK，然后构建 APK

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "   Flutter Android 一键打包工具   " -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

$ErrorActionPreference = "Continue"

# 检查 Flutter 是否已安装
$flutterPath = "C:\flutter\flutter\bin\flutter.bat"
if (-not (Test-Path $flutterPath)) {
    Write-Host "❌ Flutter 未找到！" -ForegroundColor Red
    Write-Host "请确保 Flutter 已安装在: C:\flutter\flutter" -ForegroundColor Yellow
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "✅ Flutter 已找到" -ForegroundColor Green

# 设置 Android SDK 路径
$androidSdkPath = "C:\Android\Sdk"

# 设置环境变量（不管是否已安装）
Write-Host "⚙️  设置环境变量..." -ForegroundColor Cyan
[Environment]::SetEnvironmentVariable("ANDROID_HOME", $androidSdkPath, "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $androidSdkPath, "User")
$env:ANDROID_HOME = $androidSdkPath
$env:ANDROID_SDK_ROOT = $androidSdkPath
Write-Host "✅ 环境变量已设置" -ForegroundColor Green

# 检查 Android SDK 是否已安装
if (-not (Test-Path "$androidSdkPath\platform-tools")) {
    Write-Host ""
    Write-Host "❌ Android SDK 未找到！" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先安装 Android SDK，有两种方法：" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "方法1：安装 Android Studio（推荐）" -ForegroundColor Cyan
    Write-Host "   1. 下载: https://developer.android.com/studio" -ForegroundColor White
    Write-Host "   2. 安装后，打开 Settings > Languages & Frameworks > Android SDK" -ForegroundColor White
    Write-Host "   3. 确保安装了 Android SDK Platform-Tools 和 Build-Tools" -ForegroundColor White
    Write-Host "   4. 记下 SDK Location 路径（通常是 C:\Users\你的用户名\AppData\Local\Android\Sdk）" -ForegroundColor White
    Write-Host ""
    Write-Host "方法2：只安装 Command Line Tools" -ForegroundColor Cyan
    Write-Host "   1. 访问: https://developer.android.com/studio#command-tools" -ForegroundColor White
    Write-Host "   2. 下载 Windows 版本的 Command Line Tools" -ForegroundColor White
    Write-Host "   3. 解压到 C:\Android\Sdk\cmdline-tools\latest" -ForegroundColor White
    Write-Host ""
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "✅ Android SDK 已安装" -ForegroundColor Green

# 接受许可
Write-Host ""
Write-Host "📋 接受 Android 许可协议..." -ForegroundColor Cyan
& $flutterPath doctor --android-licenses 2>&1 | Out-Null
Write-Host "✅ 许可已接受" -ForegroundColor Green

# 清理之前的构建
Write-Host ""
Write-Host "🧹 清理之前的构建..." -ForegroundColor Cyan
& $flutterPath clean | Out-Null
Write-Host "✅ 清理完成" -ForegroundColor Green

# 构建 APK
Write-Host ""
Write-Host "🔨 开始构建 APK（首次构建可能需要 15-20 分钟）..." -ForegroundColor Cyan
Write-Host "请耐心等待，不要关闭窗口..." -ForegroundColor Yellow
Write-Host ""

& $flutterPath build apk --release

# 检查构建结果
$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
if (Test-Path $apkPath) {
    Write-Host ""
    Write-Host "==================================" -ForegroundColor Green
    Write-Host "   ✅ APK 构建成功！" -ForegroundColor Green
    Write-Host "==================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "📱 APK 文件位置:" -ForegroundColor Cyan
    Write-Host "   $(Resolve-Path $apkPath)" -ForegroundColor White
    Write-Host ""
    $apkSize = (Get-Item $apkPath).Length / 1MB
    Write-Host "📦 文件大小: $([math]::Round($apkSize, 2)) MB" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📲 安装到手机的方法:" -ForegroundColor Yellow
    Write-Host "   1. 将 APK 文件传输到手机" -ForegroundColor White
    Write-Host "   2. 在手机上打开文件管理器" -ForegroundColor White
    Write-Host "   3. 点击 APK 文件安装" -ForegroundColor White
    Write-Host "   4. 如果提示未知来源，需要在设置中允许安装" -ForegroundColor White
    Write-Host ""
    
    # 打开文件夹
    Write-Host "正在打开 APK 所在文件夹..." -ForegroundColor Cyan
    explorer.exe /select,"$(Resolve-Path $apkPath)"
} else {
    Write-Host ""
    Write-Host "❌ APK 构建失败" -ForegroundColor Red
    Write-Host "请检查上面的错误信息" -ForegroundColor Yellow
    exit 1
}
