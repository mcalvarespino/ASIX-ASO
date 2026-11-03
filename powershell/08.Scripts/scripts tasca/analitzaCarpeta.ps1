# agafo els elements de la carpeta on estic per comptar-los al final.
$elements = @(Get-ChildItem)
# PSIsContainer em diu si es una carpeta. Aqui em quedo amb els fitxers.
$fitxers = @($elements | Where-Object { $_.PSIsContainer -eq $false })
# ordeno els fitxers per mida i agafo els 5 mes grans.
$fitxersGrans = $fitxers |
    Sort-Object Length -Descending |
    Select-Object -First 5 Name, Length

Write-Output "===== ANÀLISI DE LA CARPETA ====="
Write-Output "Nombre total d'elements: $($elements.Count)"
Write-Output ""
Write-Output "Cinc fitxers més grans (mida en bytes):"
$fitxersGrans | Format-Table -AutoSize
