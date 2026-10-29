Import-Module ActiveDirectory

$nomOU = $args[0]
$ruta = "DC=musiccloud,DC=local"

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
