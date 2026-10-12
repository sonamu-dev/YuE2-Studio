@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================================
echo         YuE2 Studio - Desktop Application (Tauri 2)
echo ============================================================
echo.

echo [1/3] MSVC 빌드 환경 초기화 중...
call scripts\setup-env.bat
if errorlevel 1 (
    echo [ERROR] MSVC 빌드 환경을 초기화하지 못했습니다.
    pause
    exit /b 1
)

echo.
echo [2/3] 의존성 패키지 확인 중...
if not exist "app\node_modules" (
    echo [INFO] 프론트엔드 패키지 설치 진행 (app)...
    cd /d "%~dp0app"
    call npm install
    cd /d "%~dp0"
)

if not exist "desktop\node_modules" (
    echo [INFO] 데스크톱 패키지 설치 진행 (desktop)...
    cd /d "%~dp0desktop"
    call npm install
    cd /d "%~dp0"
)

echo.
echo [3/3] YuE2 Studio 데스크톱 애플리케이션 시작 중...
cd /d "%~dp0desktop"
call npm run dev

if errorlevel 1 (
    echo.
    echo [ERROR] 데스크톱 앱이 오류 코드 %errorlevel% 로 종료되었습니다.
    pause
)