# Pi Agent Portable

> **Entorno autocontenido de [Pi Coding Agent](https://pi.dev) para Windows (USB, PCs corporativas o sin permisos de administrador).**

Instala y ejecuta **Pi Agent** junto con sus runtimes completos (**Node.js, Python, Git y Bash**) dentro de una sola carpeta. No requiere privilegios de administrador, no modifica el Registro de Windows ni toca variables globales del sistema.

---

## Características

- **100 % Portátil:** Copia toda la carpeta a una memoria USB o cualquier directorio (`C:\`, `D:\`) y úsala en cualquier equipo con Windows 10/11.
- **Sin permisos de administrador:** Descarga y extrae paquetes oficiales portátiles en espacio de usuario.
- **Aislamiento total:** La configuración, credenciales, historial y herramientas (`fd`, `rg`) viven dentro de `data/` mediante `PI_CODING_AGENT_DIR`, sin tocar `~/.pi/agent`.
- **Setup inteligente:** `setup.bat` verifica cada componente antes de descargar; si algo ya funciona, lo omite y solo instala o repara lo que falte.

---

## Inicio Rápido

1. **Descarga o clona** este repositorio en una carpeta donde tengas permisos de escritura (evita usar `&` en el nombre de la carpeta):
   ```cmd
   git clone [https://github.com/davo084/pi-agent-portable.git](https://github.com/davo084/pi-agent-portable.git)
   cd pi-agent-portable
   ```
   *(También puedes descargarlo como ZIP desde GitHub y descomprimirlo).*

2. **Instala los runtimes y Pi Agent** ejecutando:
   ```cmd
   setup.bat
   ```
   Espera a que la verificación final marque `[OK]` en **Node.js, Git, Bash, Python y Pi Agent**.

3. **Inicia Pi Agent:**
   ```cmd
   pi.cmd
   ```
   *(O desde PowerShell usando `.\pi.ps1`).*

---

## Estructura del Proyecto

```text
pi-agent-portable/
├── setup.bat        # Instala y verifica Node, PortableGit+Bash, Python y Pi Agent
├── pi.cmd           # Lanzador principal (CMD / doble clic)
├── pi.ps1           # Lanzador alternativo (PowerShell)
├── bash.cmd         # Wrapper portable de Git Bash
├── update.bat       # Actualiza Pi Agent dentro de app/ sin tocar el sistema
├── settings.json    # Configuración base (se copia a data/ en el primer arranque)
├── .gitignore       # Ignora runtimes/, app/, data/ y temporales
├── runtimes/        # (Generado) Node.js, Python y PortableGit + Bash
├── app/             # (Generado) Instalación local de @earendil-works/pi-coding-agent
└── data/            # (Generado) Sesiones, configuración y binarios auxiliares (fd, rg)
```

---

## Actualizaciones

Como Pi está instalado de forma aislada en `app/` y no de manera global, **no uses** `pi update` dentro de la CLI. Para actualizar a la última versión, ejecuta:

```cmd
update.bat
```

---

## Rutas de Runtimes Incluidos

Al iniciar mediante `pi.cmd` o `pi.ps1`, todos estos ejecutables quedan inyectados con máxima prioridad en el `PATH` de la sesión:

| Herramienta | Ruta relativa |
| :--- | :--- |
| **Node.js** | `runtimes\node\node.exe` |
| **npm** | `runtimes\node\npm.cmd` |
| **Python** | `runtimes\python\python.exe` |
| **Git** | `runtimes\git-portable\cmd\git.exe` |
| **Bash** | `runtimes\git-portable\usr\bin\bash.exe` (o `bash.cmd` en la raíz) |