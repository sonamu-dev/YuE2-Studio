@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================================
echo                    YuE2 Studio Launcher
echo ============================================================
echo.
echo 1. YuE2 Studio 데스크톱 앱 실행 (Tauri 2 GUI - 개발 모드)
echo 2. YuE2 Studio 릴리즈 바이너리 실행 (YuE2-Studio.exe)
echo 3. YuE2 Studio 웹 모드 실행 (브라우저 접속: http://127.0.0.1:3791)
echo 4. 전체 빌드 (Build Release)
echo 5. 종료
echo.
set "CHOICE=1"
set /p "CHOICE=원하시는 모드를 선택하세요 [1-5] (기본값: 1): "

if "%CHOICE%"=="1" (
    call run-desktop.bat
    goto :end
)
if "%CHOICE%"=="2" (
    if exist "desktop\src-tauri\target\release\YuE2-Studio.exe" (
        start "" "desktop\src-tauri\target\release\YuE2-Studio.exe"
    ) else (
        echo [INFO] 빌드된 바이너리가 없어 빌드를 시작합니다...
        call scripts\setup-env.bat
        cd /d "%~dp0desktop"
        call npm run build
        cd /d "%~dp0"
        if exist "desktop\src-tauri\target\release\YuE2-Studio.exe" (
            start "" "desktop\src-tauri\target\release\YuE2-Studio.exe"
        )
    )
    goto :end
)
if "%CHOICE%"=="3" (
    call run-server.bat
    goto :end
)
if "%CHOICE%"=="4" (
    call scripts\setup-env.bat
    cd /d "%~dp0app"
    call npm install
    call npm run build
    cd /d "%~dp0desktop"
    call npm install
    call npm run build
    cd /d "%~dp0"
    echo.
    echo [INFO] 빌드가 완료되었습니다.
    pause
    goto :end
)
if "%CHOICE%"=="5" (
    exit /b 0
)

echo 올바른 번호를 선택해 주세요.
pause

:end