param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local",
    [Parameter(Mandatory=$true)]
    [string[]]$descendents
)

function Buscar-UO {
    param ([string]$nom, [string]$ruta)

    # busco el nom nomes entre les filles directes de la ruta.
    Get-ADOrganizationalUnit -Filter {Name -eq $nom} -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
}

function Crear-UO {
    param ([string]$nom, [string]$ruta)

    # creo la UO i la retorno per poder agafar la seva ruta.
    New-ADOrganizationalUnit -Name $nom -Path $ruta -PassThru -ErrorAction Stop
}

# primer miro si la ruta existeix i si hi puc crear una UO.
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

# poso la principal al davant de les filles i passo per cada nom.
$rutaActual = $ruta
foreach ($nom in (@($nomOU) + $descendents)) {
    $nom = ([string]$nom).Trim()
    if ($nom -eq "" -or $nom -like "OU=*") {
        Write-Host "Escriu nomes el nom, sense OU= i sense deixar-lo buit."
        return
    }

    $uo = Buscar-UO -nom $nom -ruta $rutaActual
    # els missatges els mostro aqui al programa principal.
    if (-not $uo) {
        $uo = Crear-UO -nom $nom -ruta $rutaActual
        Write-Host "Creada: $nom"
    }
    else {
        Write-Host "Ja existeix: $nom"
    }

    # despres de la principal canvio la ruta per posar-hi les filles.
    if ($rutaActual -eq $ruta) {
        $rutaActual = $uo.DistinguishedName
    }
}
