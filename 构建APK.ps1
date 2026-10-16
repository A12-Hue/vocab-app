# 快速构建 Android APK
Write-Host "开始构建 Android APK..." -ForegroundColor Yellow
Write-Host "这可能需要 10-30 分钟（首次构建）..." -ForegroundColor Gray
Write-Host ""

Set-Location "d:\book\vocab_app"
flutter build apk --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "   APK 构建成功!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "APK 文件位置:" -ForegroundColor Yellow
    Write-Host "build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "文件大小:" -ForegroundColor Yellow
    $apkPath = "build\app\outputs\flutter-apk\app-release.apk"
    if (Test-Path $apkPath) {
        $size = (Get-Item $apkPath).Length / 1MB
        Write-Host ("{0:N2} MB" -f $size) -ForegroundColor Cyan
    }
    Write-Host ""
    Write-Host "安装到手机:" -ForegroundColor Yellow
    Write-Host "1. 将 APK 文件复制到手机" -ForegroundColor White
    Write-Host "2. 在手机上点击 APK 安装" -ForegroundColor White
    Write-Host "3. 允许安装未知来源应用" -ForegroundColor White
    Write-Host ""
    Write-Host "或者通过 USB:" -ForegroundColor Yellow
    Write-Host "  adb install build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Cyan
    Write-Host ""
    
    # 打开文件夹
    Start-Process "d:\book\vocab_app\build\app\outputs\flutter-apk"
} else {
    Write-Host ""
    Write-Host "构建失败!" -ForegroundColor Red
    Write-Host "请检查上面的错误信息" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
