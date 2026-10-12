@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================================
echo         YuE2 Studio - Web / Standalone Server Mode
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
    echo [INFO] 프론트엔드 패키지 설치 진행: app
    cd /d "%~dp0app"
    call npm install
    cd /d "%~dp0"
)

echo.
echo [3/3] 백엔드 서버 및 웹 인터페이스 구동 중...
echo [INFO] 브라우저 접속 주소: http://127.0.0.1:3791 (API: http://127.0.0.1:8791)
echo.

start "YuE2 Studio Music Server" cmd /c "call scripts\setup-env.bat && cargo run -p music-server"

timeout /t 3 /nobreak > nul

start http://127.0.0.1:3791
cd /d "%~dp0app"
call npm run dev