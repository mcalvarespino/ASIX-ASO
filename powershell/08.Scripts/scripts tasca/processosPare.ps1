# faig que els errors aturin la consulta per poder-los agafar amb try/catch.
$ErrorActionPreference = "Stop"
$processos = Get-Process

# per cada proces mostro el nom, el seu ID i els fils que te.
foreach ($proces in $processos) {
    Write-Output "============================== $($proces.ProcessName) ($($proces.Id)) =============================="
    Write-Output ""

    # intento llegir els fils perquè el proces es pot haver tancat o pot donar error.
    try {
        $threads = $proces.Threads
    } catch {
        $threads = $null
    }

    # si no he pogut llegir els fils, passo al seguent proces amb continue.
    if ($null -eq $threads) {
        Write-Output "Total threads: no disponible"
        Write-Output ""
        continue
    }

    Write-Output "Total threads: $($threads.Count)"
    Write-Output ""

    # ara miro l'ID i el temps de CPU de cada fil. Si el temps falla, el deixo buit.
    foreach ($thread in $threads) {
        try {
            $tempsCPU = $thread.TotalProcessorTime
        } catch {
            $tempsCPU = ""
        }

        Write-Output "ID: $($thread.Id) CPU TIME: $tempsCPU"
    }

    Write-Output ""
}
