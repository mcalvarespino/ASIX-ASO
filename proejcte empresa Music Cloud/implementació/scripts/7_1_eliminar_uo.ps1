$ErrorActionPreference = "Stop"

$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"

# miro si hi ha usuaris, equips o altres objectes abans de borrar les UO.
$objectes = Get-ADObject -Filter * -SearchBase $ruta | Where-Object { $_.ObjectClass -ne "organizationalUnit" }
if ($objectes) {
    Write-Host "Hi ha objectes dins de les UO, no les elimino."
    return
}

# trec la proteccio i elimino MusicCloud amb les seves UO filles.
Set-ADOrganizationalUnit -Identity $ruta -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity $ruta -Recursive -Confirm:$false

Write-Host "UO MusicCloud i descendents eliminades."
