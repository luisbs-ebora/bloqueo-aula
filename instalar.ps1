# instalar.ps1 - Lo lanza INSTALAR.bat (como administrador). Crea la tarea BloqueoAula.
$ErrorActionPreference = 'Stop'
$base = 'https://raw.githubusercontent.com/luisbs-ebora/bloqueo-aula/main'
$dir = Join-Path $env:ProgramData 'BloqueoAula'
try {
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  # Solo SYSTEM y Administradores pueden cambiar lo que hay en la carpeta; el resto, solo leer.
  icacls $dir /inheritance:r /grant:r '*S-1-5-18:(OI)(CI)F' '*S-1-5-32-544:(OI)(CI)F' '*S-1-5-32-545:(OI)(CI)RX' | Out-Null

  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Invoke-WebRequest -Uri ($base + '/actualizar.ps1') -OutFile (Join-Path $dir 'actualizar.ps1') -UseBasicParsing -TimeoutSec 30

  $accion = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument ('-NoProfile -NonInteractive -ExecutionPolicy Bypass -WindowStyle Hidden -File "' + (Join-Path $dir 'actualizar.ps1') + '"')
  $alEncender = New-ScheduledTaskTrigger -AtStartup
  $alEncender.Delay = 'PT1M'
  $cada30 = New-ScheduledTaskTrigger -Daily -At '00:00'
  $cada30.Repetition = (New-ScheduledTaskTrigger -Once -At '00:00' -RepetitionInterval (New-TimeSpan -Minutes 30) -RepetitionDuration (New-TimeSpan -Days 1)).Repetition
  $quien = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest
  $ajustes = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Minutes 10) -MultipleInstances IgnoreNew
  Register-ScheduledTask -TaskName 'BloqueoAula' -Action $accion -Trigger $alEncender, $cada30 -Principal $quien -Settings $ajustes -Description 'Descarga y aplica el bloqueo de webs del aula (repo bloqueo-aula).' -Force | Out-Null

  Start-ScheduledTask -TaskName 'BloqueoAula'
  Write-Host ''
  Write-Host ('INSTALADO en ' + $env:COMPUTERNAME + '. El bloqueo se esta aplicando ahora y se actualizara cada 30 minutos.') -ForegroundColor Green
} catch {
  Write-Host ''
  Write-Host ('HA FALLADO en ' + $env:COMPUTERNAME + ': ' + $_.Exception.Message) -ForegroundColor Red
  exit 1
}
