# Ordenem abans d'agafar els deu primers processos.
$processos = @(Get-Process)
$topProcessos = $processos |
    Sort-Object CPU -Descending |
    Select-Object -First 10 Name, Id, CPU

$topProcessos | Format-Table -AutoSize
Write-Output "Nombre total de processos: $($processos.Count)"
