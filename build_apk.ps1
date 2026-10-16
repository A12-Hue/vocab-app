# 快速打包 Android APK
Write-Host "打包 Android APK..." -ForegroundColor Cyan
Set-Location "d:\book\vocab_app"
flutter build apk --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ 打包成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "APK 文件位置：" -ForegroundColor Yellow
    Write-Host "d:\book\vocab_app\build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "你可以将此文件传到 Android 手机上安装" -ForegroundColor White
    
    # 尝试打开文件所在目录
    explorer "d:\book\vocab_app\build\app\outputs\flutter-apk"
} else {
    Write-Host ""
    Write-Host "✗ 打包失败" -ForegroundColor Red
}

Write-Host ""
Read-Host "按回车键退出"
