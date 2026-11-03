param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local",
    [Parameter(Mandatory=$true)]
    [string[]]$descendents
)

try {
    # primer miro si puc accedir a la ruta.
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

# poso la principal davant de les filles per crear-les en ordre.
$rutaActual = $ruta
foreach ($nom in (@($nomOU) + $descendents)) {
    $nom = ([string]$nom).Trim()
    if ($nom -eq "" -or $nom -like "OU=*") {
        Write-Host "Escriu nomes el nom, sense OU= i sense deixar-lo buit."
        return
    }

    # busco el nom nomes entre les UO que hi ha just dins de la ruta.
    $OU = Get-ADOrganizationalUnit -Filter {Name -eq $nom} -SearchBase $rutaActual -SearchScope OneLevel -ErrorAction Stop
    if (-not $OU) {
        $OU = New-ADOrganizationalUnit -Name $nom -Path $rutaActual -PassThru -ErrorAction Stop
        Write-Host "Creada: $nom"
    }
    else {
        Write-Host "Ja existeix: $nom"
    }

    # despres de la principal canvio la ruta perquè totes les filles hi vagin dins.
    if ($rutaActual -eq $ruta) {
        $rutaActual = $OU.DistinguishedName
    }
}
