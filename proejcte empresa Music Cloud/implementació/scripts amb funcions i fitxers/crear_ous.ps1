function Llegir-UO {
    param ([string]$fitxer)

    # llegeixo les rutes que he ficat al txt.
    Get-Content -LiteralPath $fitxer -ErrorAction Stop
}

$fitxer = Join-Path $PSScriptRoot "Dades\ous.txt"
$linies = Llegir-UO -fitxer $fitxer

foreach ($linia in $linies) {
    # la primera coma separa el nom de la ruta on va la UO.
    $nom, $ruta = $linia -split ",", 2
    $nom = $nom -replace "^OU=", ""
    Write-Host "$nom -> $ruta"
}
