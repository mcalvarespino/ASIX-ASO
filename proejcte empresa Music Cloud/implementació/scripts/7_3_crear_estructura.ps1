$nomOU = "MusicCloud"
$ruta = "DC=musiccloud,DC=local"

# primer creo MusicCloud.
New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
Write-Host "UO $nomOU creada."

# ara canvio la ruta i creo les tres UO dins de MusicCloud.
$ruta = "OU=MusicCloud,$ruta"
foreach ($nomOU in "Usuaris", "Equips", "Grups") {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
    Write-Host "UO $nomOU creada."
}
