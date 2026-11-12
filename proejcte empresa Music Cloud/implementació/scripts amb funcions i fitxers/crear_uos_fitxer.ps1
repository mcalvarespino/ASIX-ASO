param (
    [string]$fitxer = "C:\Users\Administrador\Dades\ous.txt"
)

function Llegir-UO {
    param ([string]$fitxer)

    Get-Content -LiteralPath $fitxer -ErrorAction Stop
}

function Buscar-UO {
    param ([string]$nom, [string]$ruta)

    Get-ADOrganizationalUnit -Filter { Name -eq $nom } -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
}

function Crear-UO {
    param ([string]$nom, [string]$ruta)

    New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction Stop
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
    if (Buscar-UO -nom $nom -ruta $ruta) {
        Write-Host "Ja existeix: $nom"
    }
    else {
        Crear-UO -nom $nom -ruta $ruta
        Write-Host "Creada: $nom"
    }
}
