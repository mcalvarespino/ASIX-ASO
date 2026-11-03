#Quart:
#el ordre dels arguments no importa(fer amb arguments etc..)
# ara passo el nom i la ruta amb parametres i puc canviar-ne l ordre.
param (
    [string]$nomOU,
    [string]$ruta
)

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
