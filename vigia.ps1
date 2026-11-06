# FIRMA: BLOQUEO-AULA-VIGIA
# vigia.ps1 - Lo ejecuta la tarea BloqueoAulaVigia como SYSTEM cada minuto (lo instala actualizar.ps1).
# Cierra los navegadores que no obedecen las directivas del aula (Opera, Vivaldi, Tor, Yandex, Chromium...).
# No se fija solo en el nombre del .exe (se cambia en un segundo): mira tambien el producto y el fabricante que lleva dentro y la carpeta.
# Edge, Chrome, Brave y Firefox no se tocan: esos si obedecen las directivas.
$log = Join-Path $env:ProgramData 'BloqueoAula\registro.txt'
function Anota($m) { Add-Content -Path $log -Value ('{0:yyyy-MM-dd HH:mm:ss}  {1}' -f (Get-Date), $m) }
$prohibidos = '\bOpera\b|Vivaldi|\bTor Browser|\bTor Project|Yandex|Chromium|Waterfox|LibreWolf|Pale Moon|Basilisk|SeaMonkey|Maxthon|Midori|Floorp|Thorium|Cent Browser|\bUC ?Browser|Avast Secure Browser|AVG Secure Browser|CCleaner Browser|Norton Private Browser|Comodo Dragon|Epic Privacy Browser|Slimjet|Iridium|Mullvad Browser|Zen Browser|DuckDuckGo|Ghost Browser|\bSidekick\b|Ungoogled|Supermium|Mercury Browser|K-Meleon|Falkon|\bMin Browser'
$vistos = @{}; $anotados = @{}
$fin = (Get-Date).AddSeconds(50)
do {
  foreach ($pr in (Get-Process -ErrorAction SilentlyContinue)) {
    $ruta = $null
    try { $ruta = $pr.Path } catch {}
    if (-not $ruta) { continue }
    if ($ruta.StartsWith($env:windir, [StringComparison]::OrdinalIgnoreCase)) { continue }
    if (-not $vistos.ContainsKey($ruta)) {
      $txt = $ruta
      try { $vi = (Get-Item -LiteralPath $ruta -ErrorAction Stop).VersionInfo; $txt = @($ruta, $vi.ProductName, $vi.FileDescription, $vi.CompanyName, $vi.OriginalFilename) -join ' | ' } catch {}
      $vistos[$ruta] = ($txt -match $prohibidos)
    }
    if ($vistos[$ruta]) {
      try {
        Stop-Process -Id $pr.Id -Force -ErrorAction Stop
        if (-not $anotados.ContainsKey($ruta)) { $anotados[$ruta] = 1; Anota ('Cerrado navegador no permitido: ' + $ruta) }
      } catch {}
    }
  }
  Start-Sleep -Seconds 5
} while ((Get-Date) -lt $fin)
