# Find and setup Android SDK

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Android SDK Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$sdkPaths = @(
    "D:\Android\Sdk",
    "D:\Vscode\Android\Sdk",
    "C:\Android\Sdk",
    "$env:LOCALAPPDATA\Android\Sdk",
    "$env:USERPROFILE\Android\Sdk",
    "D:\sdk",
    "C:\Users\$env:USERNAME\AppData\Local\Android\Sdk"
)

Write-Host "Searching for Android SDK..." -ForegroundColor Yellow
Write-Host ""

$foundSdk = $null
foreach ($path in $sdkPaths) {
    if (Test-Path "$path\platform-tools\adb.exe") {
        Write-Host "[FOUND] $path" -ForegroundColor Green
        $foundSdk = $path
        break
    } else {
        Write-Host "[NOT FOUND] $path" -ForegroundColor Gray
    }
}

if ($null -eq $foundSdk) {
    Write-Host ""
    Write-Host "Android SDK not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please provide your Android SDK path:" -ForegroundColor Yellow
    Write-Host "Or press Enter to open Android Studio to install SDK" -ForegroundColor Yellow
    Write-Host ""
    $userPath = Read-Host "SDK Path (or press Enter)"
    
    if ([string]::IsNullOrWhiteSpace($userPath)) {
        Write-Host ""
        Write-Host "Opening Android Studio..." -ForegroundColor Green
        Write-Host ""
        Write-Host "Steps to install SDK:" -ForegroundColor Yellow
        Write-Host "1. Open Settings (Ctrl+Alt+S)" -ForegroundColor White
        Write-Host "2. Go to: Languages & Frameworks > Android SDK" -ForegroundColor White
        Write-Host "3. Note the SDK Location path" -ForegroundColor White
        Write-Host "4. If empty, click Edit to install" -ForegroundColor White
        Write-Host "5. Run this script again with that path" -ForegroundColor White
        Write-Host ""
        
        if (Test-Path "D:\Vscode\nnn\bin\studio.exe") {
            Start-Process "D:\Vscode\nnn\bin\studio.exe"
        }
        
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        exit
    } else {
        if (Test-Path "$userPath\platform-tools\adb.exe") {
            $foundSdk = $userPath
            Write-Host "[OK] SDK found at: $userPath" -ForegroundColor Green
        } else {
            Write-Host "[ERROR] Invalid SDK path!" -ForegroundColor Red
            Write-Host "Path does not contain platform-tools\adb.exe" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Press any key to exit..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            exit
        }
    }
}

if ($null -ne $foundSdk) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "   Configuring project..." -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "SDK Path: $foundSdk" -ForegroundColor Cyan
    
    Set-Location "d:\book\vocab_app"
    
    $localProps = "sdk.dir=$($foundSdk -replace '\\', '/')"
    $localProps | Out-File -FilePath "android\local.properties" -Encoding ASCII -Force
    Write-Host "[OK] Created android\local.properties" -ForegroundColor Green
    
    $env:ANDROID_HOME = $foundSdk
    [System.Environment]::SetEnvironmentVariable("ANDROID_HOME", $foundSdk, "User")
    Write-Host "[OK] Set ANDROID_HOME environment variable" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "   Ready to build!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Run build_apk.ps1 to build your APK" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
