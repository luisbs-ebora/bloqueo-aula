@echo off
rem Instala en este equipo la actualizacion automatica del bloqueo. Solo hace falta UNA vez por equipo.
rem Basta con este archivo: lo demas lo descarga del repo bloqueo-aula.
fltmc >nul 2>&1
if errorlevel 1 (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol='Tls12'; $f=Join-Path $env:TEMP 'instalar-bloqueo.ps1'; try { Invoke-WebRequest 'https://raw.githubusercontent.com/luisbs-ebora/bloqueo-aula/main/instalar.ps1' -OutFile $f -UseBasicParsing -TimeoutSec 30 } catch { Write-Host ('No se pudo descargar el instalador: ' + $_.Exception.Message) -ForegroundColor Red; exit 1 }; & $f; exit $LASTEXITCODE"
echo.
echo Esta ventana se cierra sola en 20 segundos.
timeout /t 20 >nul
