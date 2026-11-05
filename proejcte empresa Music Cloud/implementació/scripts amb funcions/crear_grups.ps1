param (
    [Parameter(Mandatory=$true)]
    [string[]]$nomGrup,
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

# primer comprovo tots els noms de la llista.
foreach ($nom in $nomGrup) {
    $nom = ([string]$nom).Trim()
    if ($nom -eq "") {
        Write-Host "Escriu el nom del grup."
        return
    }
}

# ara passo per cada nom i creo nomes els grups que falten.
foreach ($nom in $nomGrup) {
    $nom = ([string]$nom).Trim()
    $grup = Buscar-Grup -nom $nom -ruta $uo.DistinguishedName
    if ($grup) {
        Write-Host "Ja existeix: $nom"
    }
    else {
        Crear-Grup -nom $nom -ruta $uo.DistinguishedName
        Write-Host "Creat: $nom"
    }
}
