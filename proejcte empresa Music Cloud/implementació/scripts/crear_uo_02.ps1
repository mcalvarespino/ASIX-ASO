#segon: el nom de la OU variable
# agafo el nom del primer argument. La ruta segueix fixa.
$nomOU = $args[0]
$ruta = "DC=musiccloud,DC=local"

# busco la UO amb el seu nom i la ruta completa.
try {
    $OU = Get-ADOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
}
catch {
    $OU = $null
}

# si no he trobat la UO, la creo.
if (-not $OU) {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta
    Write-Host "Creada: $nomOU"
}
else {
    Write-Host "Ja existeix: $nomOU"
}
