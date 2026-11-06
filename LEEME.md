# bloqueo-aula

Bloqueo de webs para los equipos del aula, en Edge, Chrome, Brave y Firefox (y el archivo `hosts` para la lista negra).

Hay **dos modos**, y el modo lo decide el archivo `MODO.txt` de este repo:

| Modo | Qué se bloquea | Cuándo |
|---|---|---|
| `libre` | Solo la **lista negra**: IA, juegos, descarga de otros navegadores (`BLOQUEAR-TODO.bat`) | Fuera de clase |
| `clase` | **Todo menos la lista blanca** (`LISTA-BLANCA.bat`): Google (Classroom, Drive, Docs), los laboratorios y talleres de luisbs-ebora.github.io y eboraformacion.es. La lista negra sigue activa | Durante tus clases |

Cada equipo tiene una tarea programada, **BloqueoAula**, que se ejecuta como SYSTEM al encender y **cada 5 minutos**:
descarga los tres archivos, y si algo ha cambiado (o cada 30 minutos, por si alguien ha tocado algo) aplica la lista negra
y, en modo clase, la lista blanca. Si no hay conexión, usa las últimas copias buenas.

## Otros navegadores

Edge, Chrome, Brave y Firefox obedecen las directivas. Los demás (Opera, Vivaldi, Tor, Yandex, Chromium, portables…) no,
así que una segunda tarea, **BloqueoAulaVigia**, los **cierra** en cuanto se abren: se ejecuta cada minuto y mira cada 5 segundos.
No se fija en el nombre del .exe, sino en el producto y el fabricante que lleva dentro el ejecutable, así que cambiarle el nombre no sirve.
Cada navegador cerrado queda apuntado en `registro.txt`. La lista de nombres está en `vigia.ps1` (variable `$prohibidos`).

## Cambiar de modo

1. En GitHub, abre `MODO.txt`, pulsa el lápiz, cambia la primera palabra a `clase` o `libre` y pulsa **Commit changes**. Se puede hacer desde el móvil.
2. En 5 minutos como mucho está en todos los equipos. Para que sea **al momento**: en Veyon, selecciona los equipos > **Iniciar aplicación** >
   `cmd /c schtasks /run /tn BloqueoAula`
3. Al cambiar de modo, **los navegadores abiertos se cierran solos** para que cojan el cambio. Avisa a la clase.

## Archivos

| Archivo | Para qué |
|---|---|
| `MODO.txt` | `clase` o `libre`. Es lo que cambias en cada clase. |
| `BLOQUEAR-TODO.bat` | La lista negra. Para bloquear una web nueva en los dos modos. |
| `LISTA-BLANCA.bat` | Lo único que funciona en modo clase. Para permitir una web nueva en clase. |
| `INSTALAR.bat` | Se ejecuta **una vez** en cada equipo. Crea la tarea. |
| `instalar.ps1` | Lo usa `INSTALAR.bat`. |
| `actualizar.ps1` | Lo ejecuta la tarea. Los equipos lo actualizan solos. |
| `vigia.ps1` | Lo ejecuta la tarea BloqueoAulaVigia: cierra los navegadores no permitidos. |
| `DESINSTALAR.bat` | Quita las dos tareas y la lista blanca (no quita la lista negra ya aplicada). |

## Añadir una web

- **Bloquearla** (en los dos modos): edita `BLOQUEAR-TODO.bat` como siempre.
- **Permitirla en clase**: edita `LISTA-BLANCA.bat`. Para Edge, Chrome y Brave, copia una línea `call :permite` con un número nuevo
  (un dominio incluye sus subdominios). Para Firefox, copia una línea `call :ff` con el formato `*://dominio/*` o `*://*.dominio/*`.

No borres las líneas `rem FIRMA: BLOQUEO-AULA` ni `# FIRMA: BLOQUEO-AULA-ACT`: sin ellas los equipos ignoran el archivo.

## Comprobar un equipo

- `C:\ProgramData\BloqueoAula\registro.txt`: una línea cada vez que aplica algo. «Código de salida 0» = todo bien.
- `C:\ProgramData\BloqueoAula\estado.txt`: el modo que tiene aplicado ahora.
- `chrome://policy` (o `edge://`, `brave://`): en modo clase aparecen `URLBlocklist` con `*` y `URLAllowlist` con la lista blanca.
- `schtasks /query /tn BloqueoAula`: la tarea existe y cuándo se ejecuta.
