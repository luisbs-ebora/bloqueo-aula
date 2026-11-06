# FIRMA: BLOQUEO-AULA-ACT
# actualizar.ps1 - Lo ejecuta la tarea programada BloqueoAula como SYSTEM, al encender y cada 5 minutos.
# Descarga del repo bloqueo-aula BLOQUEAR-TODO.bat (lista negra), LISTA-BLANCA.bat y MODO.txt, y aplica:
#   modo libre -> solo la lista negra;  modo clase -> lista negra + lista blanca (todo bloqueado menos lo permitido).
# Solo vuelve a aplicar si algo ha cambiado o si hace mas de 30 minutos (asi se repone si alguien borra los bloqueos).
# Sin conexion, usa las ultimas copias buenas.
$dir = Join-Path $env:ProgramData 'BloqueoAula'
$base = 'https://raw.githubusercontent.com/luisbs-ebora/bloqueo-aula/main/'
$log = Join-Path $dir 'registro.txt'
$estado = Join-Path $dir 'estado.txt'
function Anota($m) { Add-Content -Path $log -Value ('{0:yyyy-MM-dd HH:mm:ss}  {1}' -f (Get-Date), $m) }
if ((Test-Path $log) -and ((Get-Item $log).Length -gt 200KB)) { Remove-Item $log -Force }
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Descarga un archivo y solo lo guarda si contiene la firma. Devuelve $true si se ha descargado.
function Baja($nombre, $firma) {
  $tmp = Join-Path $dir ($nombre + '.tmp')
  for ($i = 1; $i -le 2; $i++) {
    try {
      Invoke-WebRequest -Uri ($base + $nombre + '?t=' + [DateTime]::UtcNow.Ticks) -OutFile $tmp -UseBasicParsing -TimeoutSec 30
      if (([IO.File]::ReadAllText($tmp)).Contains($firma)) { Move-Item -Path $tmp -Destination (Join-Path $dir $nombre) -Force; return $true }
      Remove-Item $tmp -Force; Anota ($nombre + ': lo descargado no tiene la firma, se ignora'); return $false
    } catch { if ($i -eq 2) { Anota ($nombre + ': sin conexion (' + $_.Exception.Message + ')') } else { Start-Sleep -Seconds 10 } }
  }
  return $false
}

# --- La propia tarea: cada 5 minutos y que cualquier usuario la pueda lanzar (schtasks /run desde Veyon) ---
try {
  $t = Get-ScheduledTask -TaskName 'BloqueoAula' -ErrorAction Stop
  $rep = @($t.Triggers | Where-Object { $_.Repetition -and $_.Repetition.Interval }) | Select-Object -First 1
  if (-not $rep -or $rep.Repetition.Interval -ne 'PT5M') {
    $alEncender = New-ScheduledTaskTrigger -AtStartup
    $alEncender.Delay = 'PT1M'
    $cada5 = New-ScheduledTaskTrigger -Daily -At '00:00'
    $cada5.Repetition = (New-ScheduledTaskTrigger -Once -At '00:00' -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration (New-TimeSpan -Days 1)).Repetition
    Set-ScheduledTask -TaskName 'BloqueoAula' -Trigger $alEncender, $cada5 | Out-Null
    Anota 'Tarea ajustada: al encender y cada 5 minutos'
  }
  $svc = New-Object -ComObject 'Schedule.Service'; $svc.Connect()
  $tk = $svc.GetFolder('\').GetTask('BloqueoAula')
  $sd = $tk.GetSecurityDescriptor(4)
  if ($sd -notmatch '\(A;;GRGX;;;AU\)') { $tk.SetSecurityDescriptor($sd + '(A;;GRGX;;;AU)', 0); Anota 'Tarea: cualquier usuario puede lanzarla con schtasks /run' }
} catch { Anota ('No se pudo ajustar la tarea: ' + $_.Exception.Message) }

# --- El vigia: cada minuto cierra los navegadores que no obedecen las directivas (Opera, Vivaldi, Tor...) ---
$vigia = Join-Path $dir 'vigia.ps1'
$nv = Baja 'vigia.ps1' '# FIRMA: BLOQUEO-AULA-VIGIA'
if ((Test-Path $vigia) -and -not (Get-ScheduledTask -TaskName 'BloqueoAulaVigia' -ErrorAction SilentlyContinue)) {
  try {
    $accionV = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument ('-NoProfile -NonInteractive -ExecutionPolicy Bypass -WindowStyle Hidden -File "' + $vigia + '"')
    $alEncenderV = New-ScheduledTaskTrigger -AtStartup
    $cada1 = New-ScheduledTaskTrigger -Daily -At '00:00'
    $cada1.Repetition = (New-ScheduledTaskTrigger -Once -At '00:00' -RepetitionInterval (New-TimeSpan -Minutes 1) -RepetitionDuration (New-TimeSpan -Days 1)).Repetition
    $quienV = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest
    $ajustesV = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Minutes 2) -MultipleInstances IgnoreNew
    Register-ScheduledTask -TaskName 'BloqueoAulaVigia' -Action $accionV -Trigger $alEncenderV, $cada1 -Principal $quienV -Settings $ajustesV -Description 'Cierra los navegadores que no obedecen las directivas del aula (repo bloqueo-aula).' -Force | Out-Null
    Start-ScheduledTask -TaskName 'BloqueoAulaVigia'
    Anota 'Instalada la tarea BloqueoAulaVigia (cada minuto)'
  } catch { Anota ('No se pudo crear la tarea BloqueoAulaVigia: ' + $_.Exception.Message) }
}

# --- Descargas ---
$n1 = Baja 'BLOQUEAR-TODO.bat' 'rem FIRMA: BLOQUEO-AULA'
$n2 = Baja 'LISTA-BLANCA.bat' 'rem FIRMA: BLOQUEO-AULA'
# MODO.txt: se acepta si su primera linea util empieza por clase o libre.
try {
  $tm = Join-Path $dir 'MODO.txt.tmp'
  Invoke-WebRequest -Uri ($base + 'MODO.txt?t=' + [DateTime]::UtcNow.Ticks) -OutFile $tm -UseBasicParsing -TimeoutSec 30
  $pl = (Get-Content $tm | Where-Object { $_.Trim() -and -not $_.Trim().StartsWith('#') } | Select-Object -First 1)
  if ($pl -and $pl.Trim().ToLower() -match '^(clase|libre)') { Move-Item $tm (Join-Path $dir 'MODO.txt') -Force }
  else { Remove-Item $tm -Force; Anota 'MODO.txt no empieza por clase ni libre: se ignora' }
} catch { Anota ('MODO.txt: sin conexion (' + $_.Exception.Message + ')') }

$negra = Join-Path $dir 'BLOQUEAR-TODO.bat'
$blanca = Join-Path $dir 'LISTA-BLANCA.bat'
$fmodo = Join-Path $dir 'MODO.txt'
if (-not (Test-Path $negra)) { Anota 'No hay ninguna copia de BLOQUEAR-TODO.bat: no se aplica nada'; exit 1 }

# Modo: la primera palabra de MODO.txt. Si no se entiende, libre.
$modo = 'libre'
if (Test-Path $fmodo) {
  $primera = (Get-Content $fmodo | Where-Object { $_.Trim() -and -not $_.Trim().StartsWith('#') } | Select-Object -First 1)
  if ($primera -and $primera.Trim().ToLower().StartsWith('clase')) { $modo = 'clase' }
}
if ($modo -eq 'clase' -and -not (Test-Path $blanca)) { Anota 'Modo clase pedido, pero no hay LISTA-BLANCA.bat: se queda en libre'; $modo = 'libre' }

# Huella de lo que hay que aplicar
$partes = @($negra, $blanca) | Where-Object { Test-Path $_ } | ForEach-Object { (Get-FileHash $_ -Algorithm SHA256).Hash }
$huella = (($partes -join '') + $modo)
$antes = @{ huella = ''; modo = ''; cuando = [DateTime]::MinValue }
if (Test-Path $estado) {
  $l = (Get-Content $estado -TotalCount 1).Split('|')
  if ($l.Count -eq 3) { $antes.huella = $l[0]; $antes.modo = $l[1]; $antes.cuando = [DateTime]::FromBinary([long]$l[2]) }
}
$hace = (Get-Date) - $antes.cuando
if ($huella -eq $antes.huella -and $hace.TotalMinutes -lt 30) { exit 0 }

$p = Start-Process -FilePath 'cmd.exe' -ArgumentList ('/c "' + $negra + '" /s') -Wait -PassThru -WindowStyle Hidden
$c1 = $p.ExitCode
$c2 = 0
if (Test-Path $blanca) {
  $arg = 'off'; if ($modo -eq 'clase') { $arg = 'on' }
  $p = Start-Process -FilePath 'cmd.exe' -ArgumentList ('/c "' + $blanca + '" ' + $arg + ' /s') -Wait -PassThru -WindowStyle Hidden
  $c2 = $p.ExitCode
}

# Si ha cambiado el modo, se cierran los navegadores para que cojan las directivas nuevas.
if ($antes.modo -and $antes.modo -ne $modo) {
  foreach ($n in 'chrome', 'msedge', 'brave', 'firefox') { Get-Process -Name $n -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue }
  Anota ('Cambio de modo: ' + $antes.modo + ' -> ' + $modo + '. Navegadores cerrados.')
}
Set-Content -Path $estado -Value ($huella + '|' + $modo + '|' + (Get-Date).ToBinary())
Anota ('Aplicado modo ' + $modo + '. Codigos de salida: lista negra ' + $c1 + ', lista blanca ' + $c2 + ' (0 = todo bien)')
