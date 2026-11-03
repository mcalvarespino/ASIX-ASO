# primer agafo el nom de l'equip i l'usuari que esta executant el script.
$equip = $env:COMPUTERNAME
$usuari = $env:USERNAME
# ara guardo la versio, la data i la carpeta on estic.
$versioPowerShell = $PSVersionTable.PSVersion
$data = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$directori = (Get-Location).Path

# al final mostro les dades que he guardat.
Write-Output "===== INFORMACIÓ DEL SISTEMA ====="
Write-Output ""
Write-Output "Equip: $equip"
Write-Output "Usuari: $usuari"
Write-Output "PowerShell: $versioPowerShell"
Write-Output "Data: $data"
Write-Output "Directori actual: $directori"
