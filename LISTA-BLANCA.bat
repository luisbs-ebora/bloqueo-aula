@echo off
rem FIRMA: BLOQUEO-AULA
rem LISTA BLANCA (modo clase): bloquea TODA la web menos lo que hay en la lista de abajo.
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

if /i not "%MODO%"=="on" (
  echo Modo LIBRE en %COMPUTERNAME%: solo la lista negra.
  goto fin
)

echo Modo CLASE en %COMPUTERNAME%: todo bloqueado menos la lista blanca.
for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
  reg add "HKLM\SOFTWARE\Policies\%%~K\URLBlocklist" /v "999" /t REG_SZ /d "*" /f >nul || set ERR=1
)
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "999" /t REG_SZ /d "<all_urls>" /f >nul || set ERR=1

rem ===== LISTA BLANCA de Edge, Chrome y Brave =====
rem Un dominio permite tambien sus subdominios. Lo que este en la lista negra con mas detalle
rem (gemini.google.com, google.com/search?udm=50...) sigue bloqueado.
rem Para permitir una web nueva: copia una linea, cambia el numero (que no se repita) y el dominio.
call :permite 1 "google.com"
call :permite 2 "google.es"
call :permite 3 "gstatic.com"
call :permite 4 "googleapis.com"
call :permite 5 "googleusercontent.com"
call :permite 6 "ggpht.com"
call :permite 7 "accounts.youtube.com"
call :permite 8 "luisbs-ebora.github.io"
call :permite 9 "eboraformacion.es"
call :permite 10 "cdn.jsdelivr.net"
call :permite 11 "unpkg.com"
call :permite 12 "cdnjs.cloudflare.com"

rem ===== LISTA BLANCA de Firefox =====
rem En Firefox las excepciones ganan a cualquier bloqueo, asi que aqui van solo los subdominios
rem de Google que hacen falta (con *.google.com volverian Gemini y compania).
call :ff 1 "*://google.com/*"
call :ff 2 "*://www.google.com/*"
call :ff 3 "*://www.google.es/*"
call :ff 4 "*://accounts.google.com/*"
call :ff 5 "*://myaccount.google.com/*"
call :ff 6 "*://classroom.google.com/*"
call :ff 7 "*://docs.google.com/*"
call :ff 8 "*://drive.google.com/*"
call :ff 9 "*://apis.google.com/*"
call :ff 10 "*://ogs.google.com/*"
call :ff 11 "*://play.google.com/*"
call :ff 12 "*://script.google.com/*"
call :ff 13 "*://lh3.google.com/*"
call :ff 14 "*://clients1.google.com/*"
call :ff 15 "*://clients2.google.com/*"
call :ff 16 "*://clients4.google.com/*"
call :ff 17 "*://clients5.google.com/*"
call :ff 18 "*://clients6.google.com/*"
call :ff 30 "*://*.clients6.google.com/*"
call :ff 19 "*://*.gstatic.com/*"
call :ff 20 "*://*.googleapis.com/*"
call :ff 21 "*://*.googleusercontent.com/*"
call :ff 22 "*://*.ggpht.com/*"
call :ff 23 "*://accounts.youtube.com/*"
call :ff 24 "*://luisbs-ebora.github.io/*"
call :ff 25 "*://eboraformacion.es/*"
call :ff 26 "*://*.eboraformacion.es/*"
call :ff 27 "*://cdn.jsdelivr.net/*"
call :ff 28 "*://unpkg.com/*"
call :ff 29 "*://cdnjs.cloudflare.com/*"

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
