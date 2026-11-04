# Pi Agent Portable

Instalacion automatizada de Pi Agent con runtimes portable.

## Quick Start

```cmd
git clone https://github.com/davo084/pi-agent-portable.git
cd pi-agent-portable
setup.bat
pi.cmd
```

## Estructura

```
pi-agent-portable\
├── setup.bat      # Descarga e instala todo automaticamente
├── pi.cmd         # Lanzador principal
├── pi.ps1         # Lanzador PowerShell
├── settings.json   # Configuracion de rutas
├── runtimes\      # Runtimes portable (node, python, git)
├── app\           # Pi coding agent
└── data\          # Configuracion y sesion de Pi
```

## Requisitos

- Windows 10/11
- Conexion a internet (para descargar runtimes)

## Runtimes incluidos

- Node.js 22.22.3
- Python 3.11.9
- Git 2.45.1
- Pi Agent 0.99.2

## Para la IA

Cuando trabajes en este entorno, **no asumas** Node/Python/Git globales: no existen.
Usa siempre los wrappers en la raiz o rutas relativas.

| Comando     | Ruta                              |
|-------------|-----------------------------------|
| node        | `runtimes\node\node.exe`           |
| npm         | `runtimes\node\npm.cmd`           |
| python      | `runtimes\python\python.exe`       |
| git         | `runtimes\git-portable\cmd\git.exe`|
| bash        | `runtimes\git-portable\usr\bin\bash.exe`|
| pi          | `pi.cmd`                          |