function Llegir-Servidors {
    param ([string]$ruta)

    # llegeixo un nom de servidor per linia.
    Get-Content -LiteralPath $ruta -ErrorAction Stop
}

# agafo el fitxer Dades des de la carpeta del script.
$ruta = Join-Path $PSScriptRoot "Dades\servers.txt"
$servidors = Llegir-Servidors -ruta $ruta

# numero els servidors i els mostro al programa principal.
$i = 0
foreach ($servidor in $servidors) {
    $i = $i + 1
    Write-Host "$i $servidor"
}
