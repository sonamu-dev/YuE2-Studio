# YuE2 Studio 실행 가이드 (Windows)

YuE2 Studio를 Windows 환경에서 빌드 및 실행하는 방법입니다.

---

## 1. 원클릭 실행 (가장 간편한 방법)

저장소 루트 디렉터리의 **`start.bat`** 파일을 더블 클릭하여 실행합니다.

```cmd
start.bat
```

실행 시 다음 메뉴가 제공됩니다:
- **[1] YuE2 Studio 데스크톱 앱 실행 (기본값 / 권장)**: Tauri 2 네이티브 윈도우 GUI 실행
- **[2] YuE2 Studio 웹 모드 실행**: 백엔드 `music-server` (포트 8791) 및 프론트엔드 Vite dev (포트 3791) 구동 후 기본 브라우저 자동 오픈
- **[3] 전체 의존성 설치 및 빌드**: 프론트엔드 및 데스크톱 패키지 빌드
- **[4] 종료**

---

## 2. 개별 실행 스크립트

### A. 데스크톱 앱 모드 (Tauri 2 Native GUI)
```cmd
run-desktop.bat
```
- MSVC 64비트 빌드 환경을 자동 로드하고 Tauri 개발 서버를 시작합니다.
- 네이티브 데스크톱 창이 열리며, 내장된 `music-server`와 즉시 연동됩니다.

### B. 웹 브라우저 모드 (Standalone Web Server)
```cmd
run-server.bat
```
- `music-server` 백엔드를 백그라운드로 실행하고 Vite 개발 서버를 구동합니다.
- 브라우저 주소: [http://127.0.0.1:3791](http://127.0.0.1:3791)
- 백엔드 API 상태: [http://127.0.0.1:8791/health](http://127.0.0.1:8791/health)

---

## 3. 환경 요구사항

- **OS**: Windows 10 (20H2 이상) 또는 Windows 11 (64-bit)
- **Rust**: 1.80 이상 (`rustc`, `cargo`)
- **Node.js**: v18 이상 (`node`, `npm`)
- **C++ 컴파일러**: Visual Studio 2022 C++ Build Tools (또는 Community / Professional 이상)
  - `scripts/setup-env.bat` 스크립트가 `vcvars64.bat`을 자동으로 감지하여 링크 환경을 설정합니다.
