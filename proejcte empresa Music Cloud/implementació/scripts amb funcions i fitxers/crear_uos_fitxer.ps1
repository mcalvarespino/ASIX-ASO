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

$registre = "C:\Users\Administrador\Dades\uos"
$data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if (-not (Test-Path -LiteralPath $fitxer -PathType Leaf)) {
    $missatge = "No trobo el fitxer: $fitxer"
    Write-Host $missatge
    Write-Warning "$data [WARN] $missatge" 3>> "$registre.warn"
    return
}

try {
    $linies = Llegir-UO -fitxer $fitxer
    foreach ($linia in $linies) {
        # la primera coma separa el nom de la ruta on va la UO.
        $nom, $ruta = $linia -split ",", 2
        $nom = $nom -replace "^OU=", ""
        if (Buscar-UO -nom $nom -ruta $ruta) {
            $missatge = "Ja existeix: $nom"
        }
        else {
            Crear-UO -nom $nom -ruta $ruta
            $missatge = "Creada: $nom"
        }
        Write-Host $missatge
        Write-Information "$data [INFO] $missatge | $ruta" 6>> "$registre.log"
    }
}
catch {
    Write-Error "$data [ERR] $_" -ErrorAction Continue 2>> "$registre.err"
    throw
}
