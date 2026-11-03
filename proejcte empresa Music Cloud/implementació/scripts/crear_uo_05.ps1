#cinquè:
#el nom de la OU es obligatori i la ruta si no sespecifica ha de haver-hi una by default
param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local"
)

try {
    $OU = Get-ADOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
}
catch {
    $OU = $null
}

if (-not $OU) {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta
    Write-Host "Creada: $nomOU"
}
else {
    Write-Host "Ja existeix: $nomOU"
}
