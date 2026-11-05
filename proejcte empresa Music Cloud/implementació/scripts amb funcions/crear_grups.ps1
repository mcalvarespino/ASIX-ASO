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

# el programa principal mostra si el grup ja existeix.
$grup = Buscar-Grup -nom $nomGrup -ruta $uo.DistinguishedName
if ($grup) {
    Write-Host "Ja existeix: $nomGrup"
}
else {
    Write-Host "Falta crear: $nomGrup"
}
