# =====================
# DADES DEL SISTEMA
# =====================
$processos = @(Get-Process)
$serveis = @(Get-Service)
$enExecucio = @($serveis | Where-Object { $_.Status -eq "Running" })
$noExecutats = @($serveis | Where-Object { $_.Status -ne "Running" })
$elements = @(Get-ChildItem)
$fitxers = @($elements | Where-Object { $_.PSIsContainer -eq $false })

# =====================
# PROCESSOS
# =====================
Write-Output "===== PROCESSOS ====="
$processos |
    Sort-Object CPU -Descending |
    Select-Object -First 5 Name, Id, CPU |
    Format-Table -AutoSize

# =====================
# SERVEIS
# =====================
Write-Output "===== SERVEIS ====="
Write-Output "Total de serveis: $($serveis.Count)"
Write-Output "Serveis en execució: $($enExecucio.Count)"
Write-Output "Serveis no executats: $($noExecutats.Count)"
Write-Output ""

# =====================
# FITXERS
# =====================
Write-Output "===== FITXERS ====="
$fitxers |
    Sort-Object Length -Descending |
    Select-Object -First 3 Name, Length |
    Format-Table -AutoSize

# =====================
# RESUM
# =====================
Write-Output "===== RESUM ====="
Write-Output ""
Write-Output "Processos analitzats: $($processos.Count)"
Write-Output "Serveis analitzats: $($serveis.Count)"
Write-Output "Fitxers analitzats: $($fitxers.Count)"
