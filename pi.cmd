@ECHO OFF
SETLOCAL
SET "PI_ROOT=%~dp0"
SET "PI_ROOT=%PI_ROOT:~0,-1%"
SET "PI_DATA=%PI_ROOT%\data"

SET "PI_NODE=%PI_ROOT%\runtimes\node"
SET "PI_PY=%PI_ROOT%\runtimes\python"
SET "PI_BIN=%PI_ROOT%\app\node_modules\.bin"
SET "PI_TOOLS=%PI_DATA%\bin"
SET "GIT_CMD=%PI_ROOT%\runtimes\git-portable\cmd"
SET "GIT_BIN=%PI_ROOT%\runtimes\git-portable\usr\bin"
SET "GIT_DLL=%PI_ROOT%\runtimes\git-portable\mingw64\bin"

:: Verificar que setup.bat ya se haya ejecutado
IF NOT EXIST "%PI_NODE%\node.exe" (
    ECHO [ERROR] No se encontro Node.js en "%PI_NODE%".
    ECHO Ejecuta primero 'setup.bat' para instalar el entorno portatil.
    PAUSE
    EXIT /B 1
)

IF NOT EXIST "%PI_ROOT%\app\node_modules\@earendil-works\pi-coding-agent\dist\bundle\cli.js" (
    ECHO [ERROR] No se encontro Pi Agent en "app\node_modules".
    ECHO Ejecuta primero 'setup.bat' para completar la instalacion.
    PAUSE
    EXIT /B 1
)

:: Crear carpeta data y copiar settings.json base si no existe
IF NOT EXIST "%PI_DATA%" MKDIR "%PI_DATA%"
IF EXIST "%PI_ROOT%\settings.json" (
    IF NOT EXIST "%PI_DATA%\settings.json" COPY /Y "%PI_ROOT%\settings.json" "%PI_DATA%\settings.json" >nul
)

:: Inyectar runtimes portatiles con maxima prioridad en el PATH
SET "PATH=%PI_NODE%;%PI_PY%;%PI_BIN%;%PI_TOOLS%;%GIT_CMD%;%GIT_BIN%;%GIT_DLL%;%PI_ROOT%;%PATH%"
SET "PYTHON=%PI_PY%\python.exe"
SET "SHELL=%PI_ROOT%\bash.cmd"
SET "PI_CODING_AGENT_DIR=%PI_DATA%"

:: Ejecutar Pi Coding Agent
"%PI_NODE%\node.exe" "%PI_ROOT%\app\node_modules\@earendil-works\pi-coding-agent\dist\bundle\cli.js" %*

:: Pausar solo si ocurre un error para poder leerlo
SET "EXIT_CODE=%ERRORLEVEL%"
IF %EXIT_CODE% NEQ 0 (
    ECHO.
    ECHO [ERROR] Pi Agent termino con el codigo de salida: %EXIT_CODE%
    PAUSE
)
EXIT /B %EXIT_CODE%