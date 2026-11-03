# agafo tots els serveis un cop i faig servir la mateixa llista per comptar-los.
$serveis = @(Get-Service)
# separo els que estan en marxa de la resta. Amb @() sempre tinc una llista per fer el Count.
$enExecucio = @($serveis | Where-Object { $_.Status -eq "Running" })
$noExecutats = @($serveis | Where-Object { $_.Status -ne "Running" })

# ara mostro el total i quants serveis hi ha a cada grup.
Write-Output "===== ESTAT DELS SERVEIS ====="
Write-Output ""
Write-Output "Total: $($serveis.Count)"
Write-Output "Running: $($enExecucio.Count)"
Write-Output "Not running: $($noExecutats.Count)"
