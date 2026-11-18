@ECHO OFF
SET "PI_ROOT=%~dp0"
SET "PI_ROOT=%PI_ROOT:~0,-1%"
SET "PATH=%PI_ROOT%\runtimes\node;%PI_ROOT%\runtimes\python;%PI_ROOT%\runtimes\git-portable\cmd;%PI_ROOT%\runtimes\git-portable\usr\bin;%PI_ROOT%\runtimes\git-portable\mingw64\bin;%PATH%"
"%PI_ROOT%\runtimes\git-portable\usr\bin\bash.exe" %*