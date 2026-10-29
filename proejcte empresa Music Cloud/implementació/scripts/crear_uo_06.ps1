param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local"
)

Import-Module ActiveDirectory

if ([string]::IsNullOrWhiteSpace($nomOU) -or [string]::IsNullOrWhiteSpace($ruta)) {
    Write-Host "El nom i la ruta no poden estar buits."
    return
}

$nomOU = $nomOU.Trim()
$ruta = $ruta.Trim()

if ($nomOU -like "OU=*") {
    Write-Host "Escriu nomes el nom, sense OU=."
    return
}

try {
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

try {
    $OU = Get-ADOrganizationalUnit -Filter {Name -eq $nomOU} -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
}
catch {
    Write-Host "No puc consultar les UO de la ruta."
    return
}

if (-not $OU) {
    try {
        $OU = New-ADOrganizationalUnit -Name $nomOU -Path $ruta -PassThru -ErrorAction Stop
    }
    catch {
        Write-Host "No s'ha pogut crear la UO: $nomOU"
        return
    }
    Write-Host "Creada: $nomOU"
}
else {
    Write-Host "Ja existeix: $nomOU"
}
