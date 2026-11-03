$nomOU = "MusicCloud"
$ruta = "DC=musiccloud,DC=local"

New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
Write-Host "UO $nomOU creada."
