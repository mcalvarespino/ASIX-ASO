param (
    [Parameter(Mandatory=$true)]
    [string]$nomGrup,
    [string]$ruta = "OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local"
)

function Buscar-Grup {
    param ([string]$nom, [string]$ruta)

    # busco el grup directament dins de la UO.
    Get-ADGroup -Filter {SamAccountName -eq $nom} -SearchBase $ruta -SearchScope OneLevel -ErrorAction Stop
}

function Crear-Grup {
    param ([string]$nom, [string]$ruta)

    # creo un grup de seguretat global dins de la UO.
    New-ADGroup -Name $nom -SamAccountName $nom -GroupScope Global -GroupCategory Security -Path $ruta -ErrorAction Stop
}

# primer comprovo que la ruta sigui una UO que existeix.
try {
    $uo = Get-ADOrganizationalUnit -Identity $ruta -ErrorAction Stop
}
catch {
    Write-Host "No puc accedir a la UO: $ruta"
    return
}

$nomGrup = $nomGrup.Trim()
if ($nomGrup -eq "") {
    Write-Host "Escriu el nom del grup."
    return
}

# en aquesta practica tots els grups porten GG_ i el nom.
if ($nomGrup -cnotlike "GG_?*") {
    Write-Host "El nom ha de comencar per GG_ i portar un nom al darrere."
    return
}

# si el grup falta el creo. Els missatges surten aqui.
$grup = Buscar-Grup -nom $nomGrup -ruta $uo.DistinguishedName
if ($grup) {
    Write-Host "Ja existeix: $nomGrup"
}
else {
    Crear-Grup -nom $nomGrup -ruta $uo.DistinguishedName
    Write-Host "Creat: $nomGrup"
}
