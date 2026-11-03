param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local",
    [Parameter(Mandatory=$true)]
    [string[]]$descendents
)

function Preparar-UO {
    param ([string]$nom, [string]$ruta)

    # busco el nom nomes entre les filles directes de la ruta.
    $uo = Get-ADOrganizationalUnit -Filter {Name -eq $nom} -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
    if ($uo) {
        return @{ UO = $uo; Creada = $false }
    }

    # si falta la creo i retorno les dades al programa principal.
    $uo = New-ADOrganizationalUnit -Name $nom -Path $ruta -PassThru -ErrorAction Stop
    return @{ UO = $uo; Creada = $true }
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

    $resultat = Preparar-UO -nom $nom -ruta $rutaActual
    # els missatges els mostro aqui al programa principal.
    if ($resultat.Creada) {
        Write-Host "Creada: $nom"
    }
    else {
        Write-Host "Ja existeix: $nom"
    }

    # despres de la principal canvio la ruta per posar-hi les filles.
    if ($rutaActual -eq $ruta) {
        $rutaActual = $resultat.UO.DistinguishedName
    }
}
