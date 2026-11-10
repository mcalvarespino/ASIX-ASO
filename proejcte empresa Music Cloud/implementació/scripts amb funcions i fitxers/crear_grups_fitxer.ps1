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

if (!(Test-Path -LiteralPath $fitxer -PathType Leaf)) {
    Write-Host "No trobo el fitxer: $fitxer"
    return
}

$grups = Llegir-Grups -fitxer $fitxer
foreach ($grup in $grups) {
    # mostro els missatges aqui i creo el grup nomes si falta.
    if (Buscar-Grup -nom $grup.Nom -ruta $grup.Ruta) {
        Write-Host "Ja existeix: $($grup.Nom)"
    }
    else {
        Crear-Grup -nom $grup.Nom -ruta $grup.Ruta
        Write-Host "Creat: $($grup.Nom)"
    }
}
