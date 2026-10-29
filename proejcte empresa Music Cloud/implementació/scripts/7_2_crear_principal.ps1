Import-Module ActiveDirectory
$ErrorActionPreference = "Stop"

$nomOU = "MusicCloud"
$ruta = "DC=musiccloud,DC=local"

New-ADOrganizationalUnit -Name $nomOU -Path $ruta
Write-Host "UO $nomOU creada."
