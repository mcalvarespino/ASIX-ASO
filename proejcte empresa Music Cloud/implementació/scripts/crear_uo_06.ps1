#sisè:
#el script ha de funcionar en totes le situacions valorant tots els casos no ficar Ou etc.

param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local"
)

try {
    # primer comprovo que la ruta existeix.
    $pare = Get-ADObject -Identity $ruta -ErrorAction Stop
}
catch {
    Write-Host "No puc accedir a la ruta: $ruta"
    return
}

if ($pare.ObjectClass -ne "domainDNS" -and $pare.ObjectClass -ne "organizationalUnit") {
    Write-Host "La ruta ha de ser el domini o una UO."
    return
}

# trec els espais i comprovo que nomes hi hagi el nom.
$nomOU = $nomOU.Trim()
if ($nomOU -eq "" -or $nomOU -like "OU=*") {
    Write-Host "Escriu nomes el nom, sense OU= i sense deixar-lo buit."
    return
}

# busco la UO amb el seu nom i la ruta completa.
try {
    $OU = Get-ADOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
}
catch {
    $OU = $null
}

# si no he trobat la UO, la creo.
if (-not $OU) {
    New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
    Write-Host "Creada: $nomOU"
}
else {
    Write-Host "Ja existeix: $nomOU"
}

#escric aixo per fer un push i commit que se ma passat de avans