@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET "PI_ROOT=%~dp0"
SET "PI_ROOT=%PI_ROOT:~0,-1%"

ECHO ======================================================
ECHO   PI AGENT PORTABLE - AUTOMATED SETUP
ECHO ======================================================

:: 1. Crear estructura
IF NOT EXIST "runtimes" mkdir runtimes
IF NOT EXIST "app" mkdir app
IF NOT EXIST "data" mkdir data

:: 2. Instalar Node.js 22.22.3
IF NOT EXIST "runtimes\node\node.exe" (
    ECHO [1/4] Downloading Node.js...
    curl -L -o node.zip https://nodejs.org/dist/v22.22.3/node-v22.22.3-win-x64.zip
    tar -xf node.zip
    move node-v22.22.3-win-x64 runtimes\node
    del node.zip
) ELSE (
    ECHO [1/4] Node.js already installed.
)

:: 3. Instalar Git Portable 2.45.1
IF NOT EXIST "runtimes\git-portable\cmd\git.exe" (
    ECHO [2/4] Downloading Git Portable...
    curl -L -o git-portable.7z https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/PortableGit-2.45.1-64-bit.7z.exe
    mkdir runtimes\git-portable-temp
    git-portable.7z -o"runtimes\git-portable-temp" -y
    :: Mover contenido al destino final
    for /d %%i in (runtimes\git-portable-temp\*) do (
        move "%%i" runtimes\git-portable
    )
    rmdir /s /q runtimes\git-portable-temp
    del git-portable.7z
) ELSE (
    ECHO [2/4] Git already installed.
)

:: 4. Instalar Python 3.11.9 (embeddable)
IF NOT EXIST "runtimes\python\python.exe" (
    ECHO [3/4] Downloading Python 3.11...
    curl -L -o python.zip https://www.python.org/ftp/python/3.11.9/python-3.11.9-embed-amd64.zip
    tar -xf python.zip
    mkdir runtimes\python
    move python-3.11.9-embed-amd64\* runtimes\python\ 2>nul
    del python.zip
    :: Habilitar site-packages en ._pth
    echo import site >> runtimes\python\python311._pth
) ELSE (
    ECHO [3/4] Python already installed.
)

:: 5. Instalar Pi Coding Agent via npm
IF NOT EXIST "app\node_modules\@earendil-works\pi-coding-agent" (
    ECHO [4/4] Installing Pi Agent...
    (
        echo {
        echo   "name": "pi-agent-portable",
        echo   "version": "1.0.0",
        echo   "type": "module",
        echo   "dependencies": {
        echo     "@earendil-works/pi-coding-agent": "0.99.2"
        echo   }
        echo }
    ) > app\package.json
    cd app
    ..\runtimes\node\npm.cmd install --ignore-scripts
    cd ..
) ELSE (
    ECHO [4/4] Pi Agent already installed.
)

:: 6. Verificar instalacion
ECHO.
ECHO ======================================================
ECHO   VERIFICATION
ECHO ======================================================
IF EXIST "runtimes\node\node.exe" (
    ECHO [OK] Node.js
    runtimes\node\node.exe -v
) ELSE (
    ECHO [FAIL] Node.js
)
IF EXIST "runtimes\git-portable\cmd\git.exe" (
    ECHO [OK] Git
    runtimes\git-portable\cmd\git.exe --version
) ELSE (
    ECHO [FAIL] Git
)
IF EXIST "runtimes\python\python.exe" (
    ECHO [OK] Python
    runtimes\python\python.exe -V
) ELSE (
    ECHO [FAIL] Python
)
IF EXIST "app\node_modules\@earendil-works\pi-coding-agent" (
    ECHO [OK] Pi Agent
) ELSE (
    ECHO [FAIL] Pi Agent
)

ECHO.
ECHO ======================================================
ECHO   DONE! Run 'pi.cmd' to start Pi Agent.
ECHO ======================================================
PAUSE
