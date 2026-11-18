$PiRoot = Split-Path $MyInvocation.MyCommand.Definition -Parent
$PiData = Join-Path $PiRoot "data"
$HermesNode = Join-Path $PiRoot "runtimes\node"
$HermesPy = Join-Path $PiRoot "runtimes\python"
$PiBin = Join-Path $PiRoot "app\node_modules\.bin"
$GitBin = Join-Path $PiRoot "runtimes\git-portable\usr\bin"
$GitDll = Join-Path $PiRoot "runtimes\git-portable\mingw64\bin"
if (-not (Test-Path $PiData)) { New-Item -ItemType Directory -Path $PiData | Out-Null }
$env:PATH = "$HermesNode;$HermesPy;$PiBin;$GitBin;$GitDll;$PiRoot;" + $env:PATH
$env:PI_CODING_AGENT_DIR = $PiData
$Cli = Join-Path $PiRoot "app\node_modules\@earendil-works\pi-coding-agent\dist\bundle\cli.js"
& (Join-Path $HermesNode "node.exe") $Cli @args
exit $LASTEXITCODE