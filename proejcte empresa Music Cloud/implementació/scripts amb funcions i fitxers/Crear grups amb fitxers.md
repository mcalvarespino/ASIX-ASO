# Crear grups amb fitxers

## Preparar el csv dels grups

> he ficat els 11 grups que toquen al grups.csv. A Nom hi va el nom del grup i a Ruta hi va la UO on ha d'anar. Tots van a Grups dins de MusicCloud.

[Fitxer dels grups](Dades/grups.csv)

> per provar que el csv es llegeix be el fico al Core i faig un Import-Csv. Han de sortir els 11 grups amb el nom i la ruta separats.

```powershell
PS C:\Users\Administrador> $grups = Import-Csv -LiteralPath 'C:\Users\Administrador\Dades\grups.csv'
PS C:\Users\Administrador> $grups | Format-Table Nom,Ruta -AutoSize

Nom                   Ruta
---                   ----
GG_Direccio           OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Administracio      OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Suport_Tecnic      OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Produccio_Musical  OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Informatica        OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Externs            OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Caps_Departament   OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Campanya_Estiu     OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Nou_Cataleg        OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Migracio_Servidors OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
GG_Admins_Sistema     OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local

PS C:\Users\Administrador> $grups.Count
11
```

## Crear els grups del csv

> ara he fet un script que llegeix grups.csv. Llegir-Grups llegeix el csv, Buscar-Grup busca el grup i Crear-Grup el crea si toca. Al foreach fico els missatges i faig servir el nom i la ruta de cada fila.

[Script dels grups](crear_grups_fitxer.ps1)

> per defecte agafa el csv de C:\Users\Administrador\Dades. Al Core espero que surtin els 11 grups com a existents perquè ja els tenia creats.

```powershell
PS C:\Users\Administrador> $script = 'C:\Users\Administrador\crear_grups_fitxer.ps1'
PS C:\Users\Administrador> & $script
Ja existeix: GG_Direccio
Ja existeix: GG_Administracio
Ja existeix: GG_Suport_Tecnic
Ja existeix: GG_Produccio_Musical
Ja existeix: GG_Informatica
Ja existeix: GG_Externs
Ja existeix: GG_Caps_Departament
Ja existeix: GG_Campanya_Estiu
Ja existeix: GG_Nou_Cataleg
Ja existeix: GG_Migracio_Servidors
Ja existeix: GG_Admins_Sistema
```

> per provar la creacio faig un csv temporal amb GG_ProvaCSV i el passo amb -fitxer. A la primera ha de crear el grup i a la segona ha de dir que ja existeix.

```powershell
PS C:\Users\Administrador> $csv = Join-Path $env:TEMP 'grups_prova.csv'
PS C:\Users\Administrador> [pscustomobject]@{Nom='GG_ProvaCSV'; Ruta='OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local'} | Export-Csv -LiteralPath $csv -NoTypeInformation
PS C:\Users\Administrador> & $script -fitxer $csv
Creat: GG_ProvaCSV
PS C:\Users\Administrador> & $script -fitxer $csv
Ja existeix: GG_ProvaCSV
```

> he comprovat amb Get-ADGroup que el grup es Global i Security. Ara borro el csv de prova per veure si el script avisa quan no troba el fitxer.

```powershell
PS C:\Users\Administrador> Remove-Item -LiteralPath $csv
PS C:\Users\Administrador> & $script -fitxer $csv
No trobo el fitxer: C:\Users\Administrador\AppData\Local\Temp\grups_prova.csv
```

> al final he borrat el grup de prova.
