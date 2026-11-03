$nomOU = "MusicCloud"
$ruta = "DC=musiccloud,DC=local"

New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
Write-Host "UO $nomOU creada."

$ruta = "OU=MusicCloud,$ruta"
foreach ($nomOU in "Usuaris", "Equips", "Grups") {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
    Write-Host "UO $nomOU creada."
}
