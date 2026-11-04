# Pi Agent Portable

> **Para USB, equipos restringidos, y despliegue rápido.**

**Pi Agent** es el agente de coding AI de la familia Pi — una interfaz ligera y rápida para desarrolladores, accesible desde cualquier entorno.  

Este repositorio es **Pi Agent Portable**: una version autocontenida y portatil que funciona sin instalacion, sin permisos de administrador, y sin tocar el registro de Windows. Todo vive en una sola carpeta.

## Ideal para

- **USB portability**: Copia la carpeta a un USB y usa Pi en cualquier PC con Windows.
- **Equipos restringidos**: Sin permisos de instalacion, sin registro, sin cambios al sistema.
- **Sin permisos de administrador**: Todo el proceso de instalacion funciona sin privilegios elevados. Copia, corre, listo.
- **Despliegue rapido**: `setup.bat` descarga e instala todo automaticamente.
- **Aislamiento**: Configuracion y sesion viven en `data/` (via `PI_CODING_AGENT_DIR`). Cero contacto con `~/.pi/agent`.

## Quick Start

```cmd
:: En cualquier PC con Windows (o desde USB)
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

## Caracteristicas

| Caracteristica | Detalle |
|---|---|
| **Autosuficiente** | Todo en una carpeta. Sin instalacion. |
| **Portatil** | Copia a USB, usa en cualquier Windows 10/11. |
| **Sin permisos** | No requiere admin. No toca registro. |
| **Aislado** | Runtimes propios. No afecta ni depende del sistema. |
| **Rutas relativas** | Todo funciona desde cualquier unidad (C:, D:, USB). |

## Runtimes incluidos

- Node.js 22.22.3
- Python 3.11.9
- Git 2.45.1
- Pi Agent 0.99.2

## Requisitos

- Windows 10/11
- Conexion a internet (solo para `setup.bat`, una vez)

## Actualizaciones

Si pi indica que hay un update disponible, ejecuta:

```cmd
npm install -g @earendil-works/pi-coding-agent@latest
```

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