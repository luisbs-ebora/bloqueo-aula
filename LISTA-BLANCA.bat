@echo off
rem FIRMA: BLOQUEO-AULA
rem LISTA BLANCA (modo clase): bloquea TODA la web menos lo que hay en la lista de abajo: Google Classroom, Drive
rem y sus herramientas, Canva, Kahoot y los laboratorios. Sin busquedas de Google ni de ningun otro buscador.
rem Uso:  LISTA-BLANCA.bat on   = modo clase      LISTA-BLANCA.bat off  = modo libre (solo la lista negra)
rem No hace falta ejecutarlo a mano: la tarea BloqueoAula lo aplica segun lo que diga MODO.txt en el repo.
rem Las webs de la lista negra (IA, juegos...) siguen bloqueadas tambien en modo clase.
set "MODO=%~1"
if not defined MODO set "MODO=off"
fltmc >nul 2>&1
if errorlevel 1 (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList '%MODO%' -Verb RunAs"
  exit /b
)
set ERR=0

rem Primero se quita siempre la lista blanca anterior.
for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
  reg delete "HKLM\SOFTWARE\Policies\%%~K\URLAllowlist" /f >nul 2>&1
  reg delete "HKLM\SOFTWARE\Policies\%%~K\URLBlocklist" /v "999" /f >nul 2>&1
)
reg delete "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Exceptions" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "999" /f >nul 2>&1

rem Notificaciones de webs bloqueadas siempre, en los dos modos. Las webs de estafa piden permiso para notificar
rem y luego meten avisos falsos de "virus" aunque la web este bloqueada (llegan por los servidores de Google).
rem La directiva anula tambien los permisos que ya se hubieran dado.
for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
  reg add "HKLM\SOFTWARE\Policies\%%~K" /v "DefaultNotificationsSetting" /t REG_DWORD /d 2 /f >nul || set ERR=1
)
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\Permissions\Notifications" /v "BlockNewRequests" /t REG_DWORD /d 1 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\Permissions\Notifications" /v "Locked" /t REG_DWORD /d 1 /f >nul || set ERR=1

if /i not "%MODO%"=="on" (
  echo Modo LIBRE en %COMPUTERNAME%: solo la lista negra.
  rem El buscador vuelve: si la lista negra ya puso Google sin IA se reactiva, y si no se quita la directiva.
  for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
    reg query "HKLM\SOFTWARE\Policies\%%~K" /v "DefaultSearchProviderSearchURL" >nul 2>&1 && (
      reg add "HKLM\SOFTWARE\Policies\%%~K" /v "DefaultSearchProviderEnabled" /t REG_DWORD /d 1 /f >nul || set ERR=1
    ) || (
      reg delete "HKLM\SOFTWARE\Policies\%%~K" /v "DefaultSearchProviderEnabled" /f >nul 2>&1
    )
  )
  goto fin
)

echo Modo CLASE en %COMPUTERNAME%: todo bloqueado menos la lista blanca.
for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
  reg add "HKLM\SOFTWARE\Policies\%%~K\URLBlocklist" /v "999" /t REG_SZ /d "*" /f >nul || set ERR=1
)
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "999" /t REG_SZ /d "<all_urls>" /f >nul || set ERR=1

rem ===== LISTA BLANCA de Edge, Chrome y Brave =====
rem Un dominio permite tambien sus subdominios. Lo que no este aqui, no abre: ni la busqueda de Google,
rem ni Gmail, ni YouTube, ni Maps, ni el Traductor, ni Google Sites (de ahi salen muchos juegos "desbloqueados").
rem Lo que este en la lista negra (gemini.google.com...) sigue bloqueado.
rem Para permitir una web nueva: copia una linea, cambia el numero (que no se repita) y el dominio.
rem Google: inicio de sesion y cuenta
call :permite 1 "accounts.google.com"
call :permite 2 "myaccount.google.com"
call :permite 3 "accounts.youtube.com"
call :permite 45 "accounts.google.es"
rem Google: Classroom, Drive, Documentos/Hojas/Presentaciones/Formularios, Calendar, Meet, Keep (Gmail NO)
call :permite 4 "classroom.google.com"
call :permite 5 "drive.google.com"
call :permite 6 "docs.google.com"
call :permite 7 "forms.gle"
call :permite 9 "calendar.google.com"
call :permite 10 "meet.google.com"
call :permite 11 "keep.google.com"
call :permite 12 "contacts.google.com"
call :permite 13 "script.google.com"
rem Google: piezas que usan esas webs por dentro (menu de apps, imagenes, avisos)
call :permite 14 "ogs.google.com"
call :permite 15 "apis.google.com"
call :permite 16 "clients1.google.com"
call :permite 17 "clients2.google.com"
call :permite 18 "clients4.google.com"
call :permite 19 "clients5.google.com"
call :permite 20 "clients6.google.com"
call :permite 21 "lh3.google.com"
call :permite 22 "play.google.com/log"
call :permite 23 "www.google.com/url"
call :permite 24 "www.google.com/recaptcha"
call :permite 25 "gstatic.com"
call :permite 26 "googleapis.com"
call :permite 27 "googleusercontent.com"
call :permite 28 "ggpht.com"
rem Canva
call :permite 29 "canva.com"
call :permite 30 "canva-apps.com"
call :permite 31 "canva.link"
call :permite 32 "challenges.cloudflare.com"
rem Kahoot
call :permite 33 "kahoot.it"
call :permite 34 "kahoot.com"
call :permite 35 "onetrust.com"
rem Laboratorios y talleres, web del centro y librerias que usan
call :permite 36 "luisbs-ebora.github.io"
call :permite 37 "eboraformacion.es"
call :permite 38 "cdn.jsdelivr.net"
call :permite 39 "unpkg.com"
call :permite 40 "cdnjs.cloudflare.com"
rem Simulador de protocolos que enlazan los laboratorios (solo esa web, no todo vercel.app)
call :permite 41 "protocol-explorer-alpha.vercel.app"
rem Archivos del propio equipo (las paginas HTML de los alumnos) y servidores locales (Live Server, XAMPP)
call :permite 42 "file://*"
call :permite 43 "localhost"
call :permite 44 "127.0.0.1"

rem Sin buscador en la barra de direcciones: lo que se escriba ahi solo sirve como direccion.
for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
  reg add "HKLM\SOFTWARE\Policies\%%~K" /v "DefaultSearchProviderEnabled" /t REG_DWORD /d 0 /f >nul || set ERR=1
)

rem ===== LISTA BLANCA de Firefox =====
rem En Firefox las excepciones ganan a cualquier bloqueo, asi que de Google van solo los subdominios
rem que hacen falta (con *.google.com volverian la busqueda, Gemini y compania).
call :ff 1 "*://accounts.google.com/*"
call :ff 2 "*://myaccount.google.com/*"
call :ff 3 "*://accounts.youtube.com/*"
call :ff 51 "*://accounts.google.es/*"
call :ff 4 "*://classroom.google.com/*"
call :ff 5 "*://drive.google.com/*"
call :ff 6 "*://docs.google.com/*"
call :ff 7 "*://forms.gle/*"
call :ff 9 "*://calendar.google.com/*"
call :ff 10 "*://meet.google.com/*"
call :ff 11 "*://keep.google.com/*"
call :ff 12 "*://contacts.google.com/*"
call :ff 13 "*://script.google.com/*"
call :ff 14 "*://ogs.google.com/*"
call :ff 15 "*://apis.google.com/*"
call :ff 16 "*://clients1.google.com/*"
call :ff 17 "*://clients2.google.com/*"
call :ff 18 "*://clients4.google.com/*"
call :ff 19 "*://clients5.google.com/*"
call :ff 20 "*://clients6.google.com/*"
call :ff 21 "*://*.clients6.google.com/*"
call :ff 22 "*://lh3.google.com/*"
call :ff 23 "*://play.google.com/log*"
call :ff 24 "*://www.google.com/url*"
call :ff 25 "*://www.google.com/recaptcha/*"
call :ff 26 "*://*.gstatic.com/*"
call :ff 27 "*://*.googleapis.com/*"
call :ff 28 "*://*.googleusercontent.com/*"
call :ff 29 "*://*.ggpht.com/*"
call :ff 30 "*://canva.com/*"
call :ff 31 "*://*.canva.com/*"
call :ff 32 "*://*.canva-apps.com/*"
call :ff 33 "*://canva.link/*"
call :ff 34 "*://*.canva.link/*"
call :ff 35 "*://challenges.cloudflare.com/*"
call :ff 36 "*://kahoot.it/*"
call :ff 37 "*://*.kahoot.it/*"
call :ff 38 "*://kahoot.com/*"
call :ff 39 "*://*.kahoot.com/*"
call :ff 40 "*://*.onetrust.com/*"
call :ff 41 "*://luisbs-ebora.github.io/*"
call :ff 42 "*://eboraformacion.es/*"
call :ff 43 "*://*.eboraformacion.es/*"
call :ff 44 "*://cdn.jsdelivr.net/*"
call :ff 45 "*://unpkg.com/*"
call :ff 46 "*://cdnjs.cloudflare.com/*"
call :ff 47 "*://protocol-explorer-alpha.vercel.app/*"
call :ff 48 "file:///*"
call :ff 49 "*://localhost/*"
call :ff 50 "*://127.0.0.1/*"


:fin
echo.
if %ERR%==0 (echo TODO OK.) else (echo HA FALLADO ALGUNA LINEA.)
if /i not "%~2"=="/s" pause
exit /b %ERR%

:permite
for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
  reg add "HKLM\SOFTWARE\Policies\%%~K\URLAllowlist" /v "%~1" /t REG_SZ /d "%~2" /f >nul || set ERR=1
)
exit /b

:ff
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Exceptions" /v "%~1" /t REG_SZ /d "%~2" /f >nul || set ERR=1
exit /b
