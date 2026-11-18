:: Validar que no haya caracteres & que rompan batch
ECHO "%~dp0" | findstr /C:"&" >nul
IF %ERRORLEVEL% EQU 0 (
    ECHO [ERROR] La ruta contiene el simbolo "&". Mueve la carpeta a una ruta sin simbolos especiales.
    PAUSE
    EXIT /B 1
)

@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET "PI_ROOT=%~dp0"
SET "PI_ROOT=%PI_ROOT:~0,-1%"
CD /D "%PI_ROOT%"

SET "SYS32=%SystemRoot%\System32"
SET "TEMP=%PI_ROOT%\.tmp"
SET "TMP=%PI_ROOT%\.tmp"
SET "npm_config_cache=%PI_ROOT%\.npm-cache"
IF NOT EXIST "%TEMP%" mkdir "%TEMP%"

ECHO ======================================================
ECHO   PI AGENT PORTABLE - SETUP (NODE, PYTHON, GIT, BASH)
ECHO ======================================================
ECHO Ruta raiz: %PI_ROOT%
ECHO.

IF NOT EXIST "runtimes" mkdir runtimes
IF NOT EXIST "app" mkdir app
IF NOT EXIST "data" mkdir data

:: 1. Node.js 22.22.3
"runtimes\node\node.exe" -v >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO [1/4] Node.js OK - Omitiendo descarga.
) ELSE (
    ECHO [1/4] Descargando Node.js...
    IF EXIST "runtimes\node" rmdir /s /q "runtimes\node"
    "%SYS32%\curl.exe" -L -o "%TEMP%\node.zip" https://nodejs.org/dist/v22.22.3/node-v22.22.3-win-x64.zip
    "%SYS32%\tar.exe" -xf "%TEMP%\node.zip" -C "%TEMP%"
    move "%TEMP%\node-v22.22.3-win-x64" "runtimes\node" >nul
    del "%TEMP%\node.zip"
)

:: 2. PortableGit 2.45.1 (Extraido con tar.exe, sin ejecutar .exe - Incluye git.exe y bash.exe)
"runtimes\git-portable\usr\bin\bash.exe" --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO [2/4] Git y Bash OK - Omitiendo descarga.
) ELSE (
    ECHO [2/4] Descargando PortableGit + Bash...
    IF EXIST "runtimes\git-portable" rmdir /s /q "runtimes\git-portable"
    "%SYS32%\curl.exe" -L -o "%TEMP%\portablegit.7z.exe" https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/PortableGit-2.45.1-64-bit.7z.exe
    mkdir "runtimes\git-portable"
    "%SYS32%\tar.exe" -xf "%TEMP%\portablegit.7z.exe" -C "runtimes\git-portable"
    del "%TEMP%\portablegit.7z.exe"
)

:: 3. Python 3.11.9 (Embeddable)
"runtimes\python\python.exe" -V >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO [3/4] Python OK - Omitiendo descarga.
) ELSE (
    ECHO [3/4] Descargando Python 3.11...
    IF EXIST "runtimes\python" rmdir /s /q "runtimes\python"
    "%SYS32%\curl.exe" -L -o "%TEMP%\python.zip" https://www.python.org/ftp/python/3.11.9/python-3.11.9-embed-amd64.zip
    mkdir "runtimes\python"
    "%SYS32%\tar.exe" -xf "%TEMP%\python.zip" -C "runtimes\python"
    del "%TEMP%\python.zip"
    echo import site>> "runtimes\python\python311._pth"
)

:: 4. Pi Coding Agent
IF EXIST "app\node_modules\@earendil-works\pi-coding-agent\dist\bundle\cli.js" (
    ECHO [4/4] Pi Agent OK - Omitiendo instalacion.
) ELSE (
    ECHO [4/4] Instalando Pi Agent...
    IF EXIST "app\node_modules" rmdir /s /q "app\node_modules"
    (
        echo {
        echo   "name": "pi-agent-portable",
        echo   "version": "1.0.0",
        echo   "type": "module",
	echo   "dependencies": {
        echo     "@earendil-works/pi-coding-agent": "latest"
        echo   }
        echo }
    ) > app\package.json
    PUSHD app
    CALL "%PI_ROOT%\runtimes\node\npm.cmd" install --ignore-scripts --no-audit --no-fund
    POPD
)

:: Limpieza de temporales
IF EXIST "%TEMP%" rmdir /s /q "%TEMP%"
IF EXIST "%npm_config_cache%" rmdir /s /q "%npm_config_cache%"

ECHO.
ECHO ======================================================
ECHO   VERIFICACION FINAL
ECHO ======================================================
"runtimes\node\node.exe" -v 2>nul && ECHO [OK] Node.js || ECHO [FAIL] Node.js
"runtimes\git-portable\cmd\git.exe" --version 2>nul && ECHO [OK] Git || ECHO [FAIL] Git
"runtimes\git-portable\usr\bin\bash.exe" --version >nul 2>&1 && ECHO [OK] Bash || ECHO [FAIL] Bash
"runtimes\python\python.exe" -V 2>nul && ECHO [OK] Python || ECHO [FAIL] Python
IF EXIST "app\node_modules\@earendil-works\pi-coding-agent\dist\bundle\cli.js" (ECHO [OK] Pi Agent) ELSE (ECHO [FAIL] Pi Agent)

ECHO.
PAUSE