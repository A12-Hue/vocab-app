@echo off
chcp 65001 >nul
echo ==================================
echo    Flutter Android 快速打包工具
echo ==================================
echo.

REM 设置 Android SDK 路径
set ANDROID_HOME=C:\Users\Lenovo\AppData\Local\Android\Sdk
set ANDROID_SDK_ROOT=%ANDROID_HOME%

echo ✅ Android SDK 路径已设置
echo    %ANDROID_HOME%
echo.

REM 打开 Android Studio 的 SDK Manager 说明
echo 📋 请先在 Android Studio 中安装必要组件：
echo.
echo 1. 打开 Android Studio
echo 2. 点击右上角的三个点 ⋮ 或者 File菜单
echo 3. 选择 Settings （设置）
echo 4. 左侧找到 Languages ^& Frameworks ^> Android SDK
echo 5. 在 SDK Platforms 标签页，勾选：
echo    - Android 14.0 (API 34) 或更高版本
echo 6. 在 SDK Tools 标签页，勾选：
echo    - Android SDK Build-Tools
echo    - Android SDK Command-line Tools
echo    - Android SDK Platform-Tools
echo 7. 点击 Apply 安装
echo 8. 等待安装完成后，关闭 Android Studio
echo.
echo 完成上述步骤后，
pause
echo.

REM 接受许可
echo 📋 接受 Android 许可协议...
echo y | C:\flutter\flutter\bin\flutter.bat doctor --android-licenses
echo.

REM 清理之前的构建
echo 🧹 清理之前的构建...
C:\flutter\flutter\bin\flutter.bat clean
echo.

REM 构建 APK
echo 🔨 开始构建 APK...
echo 首次构建可能需要 15-20 分钟，请耐心等待...
echo.
C:\flutter\flutter\bin\flutter.bat build apk --release

REM 检查构建结果
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo.
    echo ==================================
    echo    ✅ APK 构建成功！
    echo ==================================
    echo.
    echo 📱 APK 文件位置:
    echo    %cd%\build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo 正在打开文件夹...
    explorer.exe /select,"%cd%\build\app\outputs\flutter-apk\app-release.apk"
) else (
    echo.
    echo ❌ APK 构建失败
    echo 请检查上面的错误信息
)

echo.
pause
