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

if ($pare.ObjectClass -notin "domainDNS", "organizationalUnit") {
    Write-Host "La ruta ha de ser el domini o una UO."
    return
}

$rutaActual = $ruta
foreach ($nom in (@($nomOU) + $descendents)) {
    $nom = ([string]$nom).Trim()
    if ($nom -eq "" -or $nom -like "OU=*") {
        Write-Host "Escriu nomes el nom, sense OU= i sense deixar-lo buit."
        return
    }

    $OU = Get-ADOrganizationalUnit -Filter {Name -eq $nom} -SearchBase $rutaActual -SearchScope OneLevel -ErrorAction Stop
    if (-not $OU) {
        $OU = New-ADOrganizationalUnit -Name $nom -Path $rutaActual -PassThru -ErrorAction Stop
        Write-Host "Creada: $nom"
    }
    else {
        Write-Host "Ja existeix: $nom"
    }

    if ($rutaActual -eq $ruta) {
        $rutaActual = $OU.DistinguishedName
    }
}
