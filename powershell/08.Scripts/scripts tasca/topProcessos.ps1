# guardo tots els processos per poder comptar el total al final.
$processos = @(Get-Process)
# els ordeno de mes a menys CPU i agafo els 10 primers amb les tres dades que es demanen.
$topProcessos = $processos |
    Sort-Object CPU -Descending |
    Select-Object -First 10 Name, Id, CPU

$topProcessos | Format-Table -AutoSize
Write-Output "Nombre total de processos: $($processos.Count)"
