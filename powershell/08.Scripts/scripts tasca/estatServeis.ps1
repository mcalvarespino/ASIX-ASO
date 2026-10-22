# Guardem els serveis per fer tots els recomptes sobre la mateixa llista.
$serveis = @(Get-Service)
$enExecucio = @($serveis | Where-Object { $_.Status -eq "Running" })
$noExecutats = @($serveis | Where-Object { $_.Status -ne "Running" })

Write-Output "===== ESTAT DELS SERVEIS ====="
Write-Output ""
Write-Output "Total: $($serveis.Count)"
Write-Output "Running: $($enExecucio.Count)"
Write-Output "Not running: $($noExecutats.Count)"
