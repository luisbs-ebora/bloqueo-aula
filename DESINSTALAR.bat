@echo off
rem Quita la tarea BloqueoAula y su carpeta. NO quita los bloqueos ya aplicados:
rem para eso, usa los quitar-bloqueo-*.reg de la carpeta Bloqueo navegadores.
fltmc >nul 2>&1
if errorlevel 1 (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)
schtasks /delete /tn "BloqueoAula" /f
rmdir /s /q "%ProgramData%\BloqueoAula"
echo.
echo Tarea BloqueoAula quitada de %COMPUTERNAME%.
timeout /t 20 >nul
