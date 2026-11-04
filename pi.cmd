@ECHO OFF
SETLOCAL
SET "PI_ROOT=%~dp0"
SET "PI_ROOT=%PI_ROOT:~0,-1%"
SET "PI_DATA=%PI_ROOT%\data"
SET "HERMES_NODE=%PI_ROOT%\runtimes\node"
SET "HERMES_PY=%PI_ROOT%\runtimes\python"
SET "PI_BIN=%PI_ROOT%\app\node_modules\.bin"
SET "GIT_BIN=%PI_ROOT%\runtimes\git-portable\usr\bin"
SET "GIT_DLL=%PI_ROOT%\runtimes\git-portable\mingw64\bin"
IF NOT EXIST "%PI_DATA%" MKDIR "%PI_DATA%"
SET "PATH=%HERMES_NODE%;%HERMES_PY%;%PI_BIN%;%GIT_BIN%;%GIT_DLL%;%PI_ROOT%;%PATH%"
SET "PYTHON=%HERMES_PY%\python.exe"
SET "PI_CODING_AGENT_DIR=%PI_DATA%"
"%HERMES_NODE%\node.exe" "%PI_ROOT%\app\node_modules\@earendil-works\pi-coding-agent\dist\bundle\cli.js" %*
EXIT /B %ERRORLEVEL%