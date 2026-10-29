Import-Module ActiveDirectory
$ErrorActionPreference = "Stop"

function Crear-UO {
    param (
        [string]$nomOU,
        [string]$ruta
    )

    try {
        $OU = Get-ADOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
    }
    catch {
        $OU = $null
    }

    if (-not $OU) {
        New-ADOrganizationalUnit -Name $nomOU -Path $ruta
        Write-Host "Creada: $nomOU"
    }
    else {
        Write-Host "Ja existeix: $nomOU"
    }
}

$ruta = "DC=musiccloud,DC=local"
Crear-UO -nomOU "MusicCloud" -ruta $ruta

$empresa = "OU=MusicCloud,$ruta"
foreach ($nomOU in "Usuaris", "Equips", "Grups") {
    Crear-UO -nomOU $nomOU -ruta $empresa
}

$ruta = "OU=Usuaris,$empresa"
foreach ($nomOU in "Administracio", "Comercial", "Desenvolupament", "Sistemes", "Direccio") {
    Crear-UO -nomOU $nomOU -ruta $ruta
}

$ruta = "OU=Equips,$empresa"
foreach ($nomOU in "Clients", "Servidors") {
    Crear-UO -nomOU $nomOU -ruta $ruta
}
