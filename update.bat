@ECHO OFF
SETLOCAL
SET "PI_ROOT=%~dp0"
SET "PI_ROOT=%PI_ROOT:~0,-1%"
CD /D "%PI_ROOT%"

SET "TEMP=%PI_ROOT%\.tmp"
SET "TMP=%PI_ROOT%\.tmp"
SET "npm_config_cache=%PI_ROOT%\.npm-cache"
IF NOT EXIST "%TEMP%" mkdir "%TEMP%"

ECHO Actualizando Pi Coding Agent...
CALL "%PI_ROOT%\runtimes\node\npm.cmd" --prefix app install @earendil-works/pi-coding-agent@latest --ignore-scripts --no-audit --no-fund

IF EXIST "%TEMP%" rmdir /s /q "%TEMP%"
IF EXIST "%npm_config_cache%" rmdir /s /q "%npm_config_cache%"

ECHO.
ECHO Actualizacion completada.
PAUSE