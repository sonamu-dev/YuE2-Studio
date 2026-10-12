@echo off
chcp 65001 > nul
REM scripts/setup-env.bat
REM Locate and initialize MSVC 64-bit environment for Rust / C++ compilation

if defined VSCMD_VER (
    echo [INFO] Visual Studio environment already initialized.
    exit /b 0
)

set "VS_WHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set "VCVARS_BAT="

if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_BAT=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    goto :found
)

if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_BAT=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
    goto :found
)

if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_BAT=C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"
    goto :found
)

if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_BAT=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
    goto :found
)

if exist "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat" (
    set "VCVARS_BAT=C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
    goto :found
)

if exist "%VS_WHERE%" (
    for /f "usebackq tokens=*" %%i in (`"%VS_WHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
        if exist "%%i\VC\Auxiliary\Build\vcvars64.bat" (
            set "VCVARS_BAT=%%i\VC\Auxiliary\Build\vcvars64.bat"
            goto :found
        )
    )
)

:found
if not defined VCVARS_BAT (
    echo [ERROR] MSVC vcvars64.bat 을 찾을 수 없습니다.
    echo Visual Studio C++ 빌드 도구가 설치되어 있는지 확인해 주세요.
    exit /b 1
)

echo [INFO] MSVC x64 환경 설정 로드: "%VCVARS_BAT%"
call "%VCVARS_BAT%" > nul
if errorlevel 1 (
    echo [ERROR] vcvars64.bat 실행 실패
    exit /b 1
)
echo [INFO] MSVC x64 환경 설정 완료.
exit /b 0
