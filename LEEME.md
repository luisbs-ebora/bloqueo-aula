# bloqueo-aula

Bloqueo de webs (IA, juegos, otros navegadores) para los equipos del aula: directivas de Edge, Chrome, Brave y Firefox, y además el archivo `hosts` de Windows, que afecta a cualquier navegador.

Cada equipo tiene una tarea programada, **BloqueoAula**, que se ejecuta como SYSTEM al encender y cada 30 minutos:
descarga `BLOQUEAR-TODO.bat` de este repo y lo aplica. Si no hay conexión, vuelve a aplicar la última copia buena.

## Archivos

| Archivo | Para qué |
|---|---|
| `BLOQUEAR-TODO.bat` | La lista maestra. Es lo único que se toca para bloquear o desbloquear webs. |
| `INSTALAR.bat` | Se ejecuta **una vez** en cada equipo. Crea la tarea. |
| `instalar.ps1` | Lo usa `INSTALAR.bat`. |
| `actualizar.ps1` | Lo ejecuta la tarea cada 30 minutos. |
| `DESINSTALAR.bat` | Quita la tarea (no quita los bloqueos ya aplicados). |

## Añadir o quitar una web

1. Edita `BLOQUEAR-TODO.bat` aquí en GitHub (lápiz) y haz commit.
2. En media hora como mucho está en todos los equipos encendidos; los apagados se ponen al día al encender.
3. Para que se note en un navegador ya abierto: cerrarlo y abrirlo, o `edge://policy` / `chrome://policy` / `brave://policy` > Volver a cargar.

No borres la línea `rem FIRMA: BLOQUEO-AULA`: sin ella los equipos ignoran el archivo.

El archivo `hosts` se rellena solo a partir de la lista de Chrome: no hay que tocarlo. Solo coge los dominios
(las entradas con ruta, como `hoodamath.com/games/snowrider3d`, no van al hosts) y deja fuera los de Microsoft,
porque Windows Defender los marca como amenaza. La copia original del hosts queda en `hosts.copia-aula`.

## Comprobar un equipo

- `C:\ProgramData\BloqueoAula\registro.txt`: cada ejecución deja una línea. «Código de salida: 0» = todo bien.
- `schtasks /query /tn BloqueoAula`: la tarea existe y cuándo se ejecuta.
