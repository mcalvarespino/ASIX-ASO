Import-Module ActiveDirectory
$ErrorActionPreference = "Stop"

$ruta = "OU=MusicCloud,DC=musiccloud,DC=local"

$objectes = Get-ADObject -Filter * -SearchBase $ruta | Where-Object { $_.ObjectClass -ne "organizationalUnit" }
if ($objectes) {
    Write-Host "Hi ha objectes dins de les UO, no les elimino."
    exit
}

Set-ADOrganizationalUnit -Identity $ruta -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity $ruta -Recursive -Confirm:$false

Write-Host "UO MusicCloud i descendents eliminades."
