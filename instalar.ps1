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
  $cada5 = New-ScheduledTaskTrigger -Daily -At '00:00'
  $cada5.Repetition = (New-ScheduledTaskTrigger -Once -At '00:00' -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration (New-TimeSpan -Days 1)).Repetition
  $quien = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest
  $ajustes = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Minutes 10) -MultipleInstances IgnoreNew
  Register-ScheduledTask -TaskName 'BloqueoAula' -Action $accion -Trigger $alEncender, $cada5 -Principal $quien -Settings $ajustes -Description 'Descarga y aplica el bloqueo de webs del aula (repo bloqueo-aula): lista negra y, en modo clase, lista blanca.' -Force | Out-Null
  # Cualquier usuario puede lanzar la tarea (para aplicar un cambio de modo al momento desde Veyon: schtasks /run /tn BloqueoAula)
  $svc = New-Object -ComObject 'Schedule.Service'; $svc.Connect()
  $tk = $svc.GetFolder('\').GetTask('BloqueoAula')
  $tk.SetSecurityDescriptor($tk.GetSecurityDescriptor(4) + '(A;;GRGX;;;AU)', 0)

  # Se aplica ya, con esta cuenta (que si tiene salida a Internet), y queda guardada la copia para la tarea.
  $bat = Join-Path $dir 'BLOQUEAR-TODO.bat'
  Invoke-WebRequest -Uri ($base + '/BLOQUEAR-TODO.bat?t=' + [DateTime]::UtcNow.Ticks) -OutFile $bat -UseBasicParsing -TimeoutSec 30
  if (-not ([IO.File]::ReadAllText($bat)).Contains('rem FIRMA: BLOQUEO-AULA')) { throw 'Lo descargado no es el script de bloqueo' }
  $p = Start-Process -FilePath 'cmd.exe' -ArgumentList ('/c "' + $bat + '" /s') -Wait -PassThru -WindowStyle Hidden
  Add-Content -Path (Join-Path $dir 'registro.txt') -Value ('{0:yyyy-MM-dd HH:mm:ss}  Instalado y aplicado por el instalador. Codigo de salida: {1}' -f (Get-Date), $p.ExitCode)
  if ($p.ExitCode -ne 0) { throw ('BLOQUEAR-TODO.bat ha terminado con errores (codigo ' + $p.ExitCode + ')') }
  Start-ScheduledTask -TaskName 'BloqueoAula'
  Write-Host ''
  Write-Host ('INSTALADO en ' + $env:COMPUTERNAME + '. Bloqueo aplicado. Se actualiza solo cada 5 minutos (modo libre o clase segun MODO.txt).') -ForegroundColor Green
} catch {
  Write-Host ''
  Write-Host ('HA FALLADO en ' + $env:COMPUTERNAME + ': ' + $_.Exception.Message) -ForegroundColor Red
  exit 1
}
