param (
    [string]$fitxer = "C:\Users\Administrador\Dades\grups.csv"
)

function Llegir-Grups {
    param ([string]$fitxer)

    # agafo el nom i la ruta de cada fila del csv.
    Import-Csv -LiteralPath $fitxer -ErrorAction Stop
}

function Buscar-Grup {
    param ([string]$nom, [string]$ruta)

    # miro si el grup ja existeix a la UO de la fila.
    Get-ADGroup -Filter {SamAccountName -eq $nom} -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
}

function Crear-Grup {
    param ([string]$nom, [string]$ruta)

    # creo el grup de seguretat global a la UO del csv.
    New-ADGroup -Name $nom -SamAccountName $nom -GroupScope Global -GroupCategory Security -Path $ruta -ErrorAction Stop
}

$registre = "C:\Users\Administrador\Dades\grups"
$data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if (-not (Test-Path -LiteralPath $fitxer -PathType Leaf)) {
    $missatge = "No trobo el fitxer: $fitxer"
    Write-Host $missatge
    Write-Warning "$data [WARN] $missatge" 3>> "$registre.warn"
    return
}

try {
    $grups = Llegir-Grups -fitxer $fitxer
    foreach ($grup in $grups) {
        # mostro els missatges aqui i creo el grup nomes si falta.
        if (Buscar-Grup -nom $grup.Nom -ruta $grup.Ruta) {
            $missatge = "Ja existeix: $($grup.Nom)"
        }
        else {
            Crear-Grup -nom $grup.Nom -ruta $grup.Ruta
            $missatge = "Creat: $($grup.Nom)"
        }
        Write-Host $missatge
        Write-Information "$data [INFO] $missatge | $($grup.Ruta)" 6>> "$registre.log"
    }
}
catch {
    Write-Error "$data [ERR] $_" -ErrorAction Continue 2>> "$registre.err"
    throw
}
