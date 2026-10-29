Import-Module ActiveDirectory
$ErrorActionPreference = "Stop"

$nomOU = "MusicCloud"
$ruta = "DC=musiccloud,DC=local"

New-ADOrganizationalUnit -Name $nomOU -Path $ruta
Write-Host "UO $nomOU creada."

$ruta = "OU=MusicCloud,$ruta"
$noms = "Usuaris", "Equips", "Grups"

foreach ($nomOU in $noms) {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta
    Write-Host "UO $nomOU creada."
}
