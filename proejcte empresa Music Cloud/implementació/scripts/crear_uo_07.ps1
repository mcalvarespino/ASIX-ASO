#setè:
#es crear la OU i crearla a un lloc peor lo especial que te es que ha de crear totes les Uo's que tu li diguins que están a un llco per exmeple tinc Musiccloud i dins Usuaris de Uo's i després departamento a les hores el script ha de crear tots els departamento pero si tu li dius que la teva ruta es per exemple muscicloud equips el script automaticament ha de crear clients i servers(no hardcoded)

param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local",
    [Parameter(Mandatory=$true)]
    [string[]]$descendents
)

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

$nomOU = $nomOU.Trim()
if ($nomOU -eq "" -or $nomOU -like "OU=*") {
    Write-Host "Escriu nomes el nom, sense OU= i sense deixar-lo buit."
    return
}

$OU = Get-ADOrganizationalUnit -Filter {Name -eq $nomOU} -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
if (-not $OU) {
    $OU = New-ADOrganizationalUnit -Name $nomOU -Path $ruta -PassThru -ErrorAction Stop
    Write-Host "Creada: $nomOU"
}
else {
    Write-Host "Ja existeix: $nomOU"
}

$rutaFilles = $OU.DistinguishedName
foreach ($nomFill in $descendents) {
    $nomFill = ([string]$nomFill).Trim()
    if ($nomFill -eq "" -or $nomFill -like "OU=*") {
        Write-Host "Escriu nomes el nom de cada UO filla, sense OU= i sense deixar-lo buit."
        return
    }

    $filla = Get-ADOrganizationalUnit -Filter {Name -eq $nomFill} -SearchBase $rutaFilles -SearchScope OneLevel -ErrorAction Stop
    if (-not $filla) {
        New-ADOrganizationalUnit -Name $nomFill -Path $rutaFilles -ErrorAction Stop
        Write-Host "Creada: $nomFill"
    }
    else {
        Write-Host "Ja existeix: $nomFill"
    }
}
