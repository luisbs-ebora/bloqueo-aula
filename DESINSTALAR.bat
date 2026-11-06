@echo off
rem Quita la tarea BloqueoAula, su carpeta y la lista blanca. NO quita la lista negra ya aplicada:
rem para eso, usa los quitar-bloqueo-*.reg de la carpeta Bloqueo navegadores.
fltmc >nul 2>&1
if errorlevel 1 (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)
schtasks /delete /tn "BloqueoAula" /f
schtasks /delete /tn "BloqueoAulaVigia" /f >nul 2>&1
rem Quita la lista blanca (modo clase) para que el equipo no se quede con todo bloqueado.
for %%K in ("Google\Chrome" "Microsoft\Edge" "BraveSoftware\Brave") do (
  reg delete "HKLM\SOFTWARE\Policies\%%~K\URLAllowlist" /f >nul 2>&1
  reg delete "HKLM\SOFTWARE\Policies\%%~K\URLBlocklist" /v "999" /f >nul 2>&1
)
reg delete "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Exceptions" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "999" /f >nul 2>&1
rmdir /s /q "%ProgramData%\BloqueoAula"
echo.
echo Tarea BloqueoAula quitada de %COMPUTERNAME%.
timeout /t 20 >nul
