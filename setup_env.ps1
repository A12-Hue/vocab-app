# Flutter Environment Setup Script
Write-Host "Setting up Flutter environment variables..." -ForegroundColor Cyan

# Get current user Path
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

# Check if Flutter path exists
$flutterPath = "C:\flutter\flutter\bin"
if ($currentPath -notlike "*$flutterPath*") {
    # Add Flutter to Path
    $newPath = $currentPath + ";" + $flutterPath
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
    Write-Host "Added Flutter to Path" -ForegroundColor Green
} else {
    Write-Host "Flutter already in Path" -ForegroundColor Green
}

# Set China mirror
[System.Environment]::SetEnvironmentVariable("PUB_HOSTED_URL", "https://pub.flutter-io.cn", [System.EnvironmentVariableTarget]::User)
Write-Host "Set PUB_HOSTED_URL" -ForegroundColor Green

[System.Environment]::SetEnvironmentVariable("FLUTTER_STORAGE_BASE_URL", "https://storage.flutter-io.cn", [System.EnvironmentVariableTarget]::User)
Write-Host "Set FLUTTER_STORAGE_BASE_URL" -ForegroundColor Green

Write-Host ""
Write-Host "Environment variables configured successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Please close this terminal and open a new one" -ForegroundColor Yellow
Write-Host "Then run: flutter doctor" -ForegroundColor Cyan
Write-Host ""
