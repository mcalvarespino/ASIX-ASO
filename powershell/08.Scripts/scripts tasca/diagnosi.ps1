# =====================
# DADES DEL SISTEMA
# =====================
# agafo les dades un cop per fer les taules i els recomptes del resum.
$processos = @(Get-Process)
$serveis = @(Get-Service)
$enExecucio = @($serveis | Where-Object { $_.Status -eq "Running" })
$noExecutats = @($serveis | Where-Object { $_.Status -ne "Running" })
$elements = @(Get-ChildItem)
$fitxers = @($elements | Where-Object { $_.PSIsContainer -eq $false })

# =====================
# PROCESSOS
# =====================
# mostro els 5 processos que tenen mes temps de CPU acumulat.
Write-Output "===== PROCESSOS ====="
$processos |
    Sort-Object CPU -Descending |
    Select-Object -First 5 Name, Id, CPU |
    Format-Table -AutoSize

# =====================
# SERVEIS
# =====================
# compto els serveis totals, els que estan en marxa i la resta.
Write-Output "===== SERVEIS ====="
Write-Output "Total de serveis: $($serveis.Count)"
Write-Output "Serveis en execució: $($enExecucio.Count)"
Write-Output "Serveis no executats: $($noExecutats.Count)"
Write-Output ""

# =====================
# FITXERS
# =====================
# de la carpeta actual mostro els 3 fitxers mes grans.
Write-Output "===== FITXERS ====="
$fitxers |
    Sort-Object Length -Descending |
    Select-Object -First 3 Name, Length |
    Format-Table -AutoSize

# =====================
# RESUM
# =====================
# al final poso quants processos, serveis i fitxers he analitzat.
Write-Output "===== RESUM ====="
Write-Output ""
Write-Output "Processos analitzats: $($processos.Count)"
Write-Output "Serveis analitzats: $($serveis.Count)"
Write-Output "Fitxers analitzats: $($fitxers.Count)"
