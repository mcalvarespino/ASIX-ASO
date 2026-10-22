# Informacio basica de l'equip on executem el script.
$equip = $env:COMPUTERNAME
$usuari = $env:USERNAME
$versioPowerShell = $PSVersionTable.PSVersion
$data = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$directori = (Get-Location).Path

Write-Output "===== INFORMACIÓ DEL SISTEMA ====="
Write-Output ""
Write-Output "Equip: $equip"
Write-Output "Usuari: $usuari"
Write-Output "PowerShell: $versioPowerShell"
Write-Output "Data: $data"
Write-Output "Directori actual: $directori"
