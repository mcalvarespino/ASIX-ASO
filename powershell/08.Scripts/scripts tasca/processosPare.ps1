# Alguns processos es poden tancar o no deixar consultar els seus threads.
$ErrorActionPreference = "Stop"
$processos = Get-Process

foreach ($proces in $processos) {
    Write-Output "============================== $($proces.ProcessName) ($($proces.Id)) =============================="
    Write-Output ""

    try {
        $threads = $proces.Threads
    } catch {
        $threads = $null
    }

    if ($null -eq $threads) {
        Write-Output "Total threads: no disponible"
        Write-Output ""
        continue
    }

    Write-Output "Total threads: $($threads.Count)"
    Write-Output ""

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
