#fer script ficar un altre nom i modificarlo 

#es incremental es a dir es fa el primer despres el segon aprteix del priemr cambiant coses etc..

#primer script:
# crear uns cript que creii una OU amb valors fixes(utilitzant variables)

# aqui deixo el nom i la ruta fixos.
$nomOU = "MusicCloud"
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
