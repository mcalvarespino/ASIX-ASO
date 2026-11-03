$nomOU = "MusicCloud"
$ruta = "DC=musiccloud,DC=local"

# creo MusicCloud directament dins del domini.
New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
Write-Host "UO $nomOU creada."
