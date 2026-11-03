#cinquè:
#el nom de la OU es obligatori i la ruta si no sespecifica ha de haver-hi una by default
# el nom es obligatori. Si no passo ruta, faig servir el domini.
param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local"
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
