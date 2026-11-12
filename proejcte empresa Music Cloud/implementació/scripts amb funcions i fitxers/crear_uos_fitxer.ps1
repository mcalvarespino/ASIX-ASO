param (
    [string]$fitxer = "C:\Users\Administrador\Dades\ous.txt"
)

function Llegir-UO {
    param ([string]$fitxer)

    Get-Content -LiteralPath $fitxer -ErrorAction Stop
}

if (-not (Test-Path -LiteralPath $fitxer -PathType Leaf)) {
    Write-Host "No trobo el fitxer: $fitxer"
    return
}

$linies = Llegir-UO -fitxer $fitxer
foreach ($linia in $linies) {
    # la primera coma separa el nom de la ruta on va la UO.
    $nom, $ruta = $linia -split ",", 2
    $nom = $nom -replace "^OU=", ""
    Write-Host "$nom -> $ruta"
}
