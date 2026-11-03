# actualizar.ps1 - Lo ejecuta la tarea programada BloqueoAula como SYSTEM.
# Descarga BLOQUEAR-TODO.bat del repo bloqueo-aula y lo aplica.
# Sin conexion, vuelve a aplicar la ultima copia buena (asi se repone si alguien borra los bloqueos).
$dir = Join-Path $env:ProgramData 'BloqueoAula'
$url = 'https://raw.githubusercontent.com/luisbs-ebora/bloqueo-aula/main/BLOQUEAR-TODO.bat'
$bueno = Join-Path $dir 'BLOQUEAR-TODO.bat'
$tmp = Join-Path $dir 'descarga.tmp'
$log = Join-Path $dir 'registro.txt'

function Anota($m) { Add-Content -Path $log -Value ('{0:yyyy-MM-dd HH:mm:ss}  {1}' -f (Get-Date), $m) }

if ((Test-Path $log) -and ((Get-Item $log).Length -gt 200KB)) { Remove-Item $log -Force }
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$descargado = $false
for ($i = 1; $i -le 3 -and -not $descargado; $i++) {
  try {
    Invoke-WebRequest -Uri ($url + '?t=' + [DateTime]::UtcNow.Ticks) -OutFile $tmp -UseBasicParsing -TimeoutSec 30
    $txt = [IO.File]::ReadAllText($tmp)
    if ($txt.StartsWith('@echo off') -and $txt.Contains('rem FIRMA: BLOQUEO-AULA')) {
      Move-Item -Path $tmp -Destination $bueno -Force
      $descargado = $true
      Anota 'Descargado de GitHub'
    } else {
      Remove-Item $tmp -Force
      Anota 'Lo descargado no es el script (falta la firma): se ignora'
      break
    }
  } catch {
    Anota ('Intento ' + $i + ' sin conexion: ' + $_.Exception.Message)
    Start-Sleep -Seconds 20
  }
}

if (-not (Test-Path $bueno)) { Anota 'No hay ninguna copia del script: no se aplica nada'; exit 1 }
if (-not $descargado) { Anota 'Se aplica la ultima copia buena guardada' }

$p = Start-Process -FilePath 'cmd.exe' -ArgumentList ('/c "' + $bueno + '" /s') -Wait -PassThru -WindowStyle Hidden
Anota ('Aplicado. Codigo de salida: ' + $p.ExitCode + ' (0 = todo bien)')
