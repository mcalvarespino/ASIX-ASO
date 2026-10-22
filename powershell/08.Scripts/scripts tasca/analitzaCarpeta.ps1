# Get-ChildItem treballa amb el directori actual.
$elements = @(Get-ChildItem)
$fitxers = @($elements | Where-Object { $_.PSIsContainer -eq $false })
$fitxersGrans = $fitxers |
    Sort-Object Length -Descending |
    Select-Object -First 5 Name, Length

Write-Output "===== ANÀLISI DE LA CARPETA ====="
Write-Output "Nombre total d'elements: $($elements.Count)"
Write-Output ""
Write-Output "Cinc fitxers més grans (mida en bytes):"
$fitxersGrans | Format-Table -AutoSize
