param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local",
    [Parameter(Mandatory=$true)]
    [string[]]$descendents
)

$crearUO = Join-Path $PSScriptRoot "crear_uo_06.ps1"
$OU = & $crearUO -nomOU $nomOU -ruta $ruta -PassThru
if (-not $OU) {
    return
}

foreach ($nomFill in $descendents) {
    if ([string]::IsNullOrWhiteSpace($nomFill)) {
        Write-Host "Escriu el nom de la UO filla."
        return
    }

    $filla = & $crearUO -nomOU $nomFill -ruta $OU.DistinguishedName -PassThru
    if (-not $filla) {
        return
    }
}
