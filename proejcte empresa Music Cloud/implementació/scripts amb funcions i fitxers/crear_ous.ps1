function Llegir-UO {
    param ([string]$fitxer)

    # llegeixo les rutes que he ficat al txt.
    Get-Content -LiteralPath $fitxer -ErrorAction Stop
}

function Buscar-UO {
    param ([string]$nom, [string]$ruta)

    # busco la UO directament dins de la ruta del txt.
    Get-ADOrganizationalUnit -Filter {Name -eq $nom} -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
}

function Crear-UO {
    param ([string]$nom, [string]$ruta)

    New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction Stop
}

$fitxer = "C:\Users\Administrador\Dades\ous.txt"
if (!(Test-Path -LiteralPath $fitxer -PathType Leaf)) {
    Write-Host "No trobo el fitxer ous.txt."
    return
}

$linies = Llegir-UO -fitxer $fitxer

foreach ($linia in $linies) {
    # la primera coma separa el nom de la ruta on va la UO.
    $nom, $ruta = $linia -split ",", 2
    $nom = $nom -replace "^OU=", ""
    # si ja hi es, nomes ho mostro. Si falta, la creo.
    if (Buscar-UO -nom $nom -ruta $ruta) {
        Write-Host "Ja existeix: $nom"
    }
    else {
        Crear-UO -nom $nom -ruta $ruta
        Write-Host "Creada: $nom"
    }
}
