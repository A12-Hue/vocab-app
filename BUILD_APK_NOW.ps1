# One-click APK builder
# Automatically finds SDK and builds APK

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Vocab App - APK Builder" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "d:\book\vocab_app"

# Step 1: Find Android SDK
Write-Host "[1/3] Finding Android SDK..." -ForegroundColor Yellow

$sdkPaths = @(
    "D:\Android\Sdk",
    "D:\Vscode\Android\Sdk", 
    "C:\Android\Sdk",
    "$env:LOCALAPPDATA\Android\Sdk",
    "$env:USERPROFILE\Android\Sdk"
)

$foundSdk = $null
foreach ($path in $sdkPaths) {
    if (Test-Path "$path\platform-tools\adb.exe") {
        $foundSdk = $path
        Write-Host "      Found SDK: $path" -ForegroundColor Green
        break
    }
}

if ($null -eq $foundSdk) {
    Write-Host "      SDK not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please enter Android SDK path:" -ForegroundColor Yellow
    Write-Host "(Open Android Studio > Settings > Android SDK to find path)" -ForegroundColor Gray
    Write-Host ""
    $userSdk = Read-Host "SDK Path"
    
    if (Test-Path "$userSdk\platform-tools\adb.exe") {
        $foundSdk = $userSdk
        Write-Host "      SDK validated!" -ForegroundColor Green
    } else {
        Write-Host "      Invalid SDK path!" -ForegroundColor Red
        pause
        exit 1
    }
}

# Step 2: Configure project
Write-Host ""
Write-Host "[2/3] Configuring project..." -ForegroundColor Yellow

$localPropsContent = "sdk.dir=$($foundSdk -replace '\\', '/')"
$localPropsContent | Out-File -FilePath "android\local.properties" -Encoding ASCII -Force
Write-Host "      Created android\local.properties" -ForegroundColor Green

$env:ANDROID_HOME = $foundSdk
Write-Host "      Set ANDROID_HOME=$foundSdk" -ForegroundColor Green

# Step 3: Build APK
Write-Host ""
Write-Host "[3/3] Building APK..." -ForegroundColor Yellow
Write-Host "      This will take 10-30 minutes on first build" -ForegroundColor Gray
Write-Host "      Please wait..." -ForegroundColor Gray
Write-Host ""

flutter build apk --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "   BUILD SUCCESS!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $apkFile = "build\app\outputs\flutter-apk\app-release.apk"
    if (Test-Path $apkFile) {
        $size = (Get-Item $apkFile).Length / 1MB
        $fullPath = Resolve-Path $apkFile
        
        Write-Host "APK Details:" -ForegroundColor Yellow
        Write-Host "  File: $fullPath" -ForegroundColor Cyan
        Write-Host ("  Size: {0:N2} MB" -f $size) -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Next Steps:" -ForegroundColor Yellow
        Write-Host "  1. Transfer app-release.apk to your Android phone" -ForegroundColor White
        Write-Host "  2. Open the APK file on your phone" -ForegroundColor White
        Write-Host "  3. Allow installation from unknown sources if prompted" -ForegroundColor White
        Write-Host "  4. Install and enjoy!" -ForegroundColor White
        Write-Host ""
        
        # Open folder
        Write-Host "Opening APK folder..." -ForegroundColor Green
        Start-Process "explorer.exe" "/select,`"$fullPath`""
    }
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "   BUILD FAILED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Common Solutions:" -ForegroundColor Yellow
    Write-Host "1. Accept Android licenses:" -ForegroundColor White
    Write-Host "   flutter doctor --android-licenses" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. Check Flutter setup:" -ForegroundColor White
    Write-Host "   flutter doctor -v" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "3. Clean and retry:" -ForegroundColor White
    Write-Host "   flutter clean" -ForegroundColor Cyan
    Write-Host "   flutter pub get" -ForegroundColor Cyan
    Write-Host ""
}

Write-Host ""
pause
