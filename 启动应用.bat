@echo off
chcp 65001 >nul
echo 正在启动词汇学习应用...
echo.
cd /d "%~dp0build\web"
start "" "http://localhost:8080"
powershell -File server.ps1
