# Crear UOs amb fitxers

## Primera prova

> he agafat el de grups que ja tenia fet i he canviat `Import-Csv` per `Get-Content` per llegir l'`ous.txt`. Al `foreach` separo cada linia per la primera coma. Trec `OU=` del nom i la resta es la ruta on va la UO.

[Script de les UO](crear_uos_fitxer.ps1) · [Fitxer de les UO](Dades/ous.txt)

> ho provo al Core i espero que surtin les 8 UO amb el nom i la ruta separats.

```powershell
PS C:\Users\Administrador> & 'C:\Users\Administrador\crear_uos_fitxer.ps1'
MusicCloud -> DC=musiccloud,DC=local
Usuaris -> OU=MusicCloud,DC=musiccloud,DC=local
Interns -> OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local
Externs -> OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local
Grups -> OU=MusicCloud,DC=musiccloud,DC=local
Equips -> OU=MusicCloud,DC=musiccloud,DC=local
Servidors -> OU=MusicCloud,DC=musiccloud,DC=local
Comptes_de_servei -> OU=MusicCloud,DC=musiccloud,DC=local
```

## Buscar i crear les UO

> ara he adaptat la part de buscar i crear del script de grups. `Buscar-UO` mira si la UO ja hi es a la ruta del TXT i `Crear-UO` la crea si falta. Els missatges els fico al `foreach`.

> primer ho provo amb l'`ous.txt` de sempre. Espero que digui que les 8 UO ja existeixen.

```powershell
PS C:\Users\Administrador> $script = 'C:\Users\Administrador\crear_uos_fitxer.ps1'
PS C:\Users\Administrador> & $script
Ja existeix: MusicCloud
Ja existeix: Usuaris
Ja existeix: Interns
Ja existeix: Externs
Ja existeix: Grups
Ja existeix: Equips
Ja existeix: Servidors
Ja existeix: Comptes_de_servei
```

> despres faig un TXT de prova amb `ProvaUOFitxer` dins de `MusicCloud`. Espero que la primera vegada la crei i la segona digui que ja hi es.

```powershell
PS C:\Users\Administrador> $prova = 'C:\Users\Administrador\Dades\ous_prova.txt'
PS C:\Users\Administrador> $dn = 'OU=ProvaUOFitxer,OU=MusicCloud,DC=musiccloud,DC=local'
PS C:\Users\Administrador> $dn | Set-Content -LiteralPath $prova
PS C:\Users\Administrador> & $script -fitxer $prova
Creada: ProvaUOFitxer
PS C:\Users\Administrador> & $script -fitxer $prova
Ja existeix: ProvaUOFitxer
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Identity $dn | Select-Object -ExpandProperty DistinguishedName
OU=ProvaUOFitxer,OU=MusicCloud,DC=musiccloud,DC=local
```

> al final he borrat la UO i el TXT de prova.

## Primera prova dels logs

> he ficat els logs com als apunts. Agafo la data una vegada quan executo el script. Amb `6>>` guardo el que es crea o ja hi era a `uos.log`, amb `3>>` guardo els avisos a `uos.warn` i amb `2>>` guardo els errors a `uos.err`. Queden a la carpeta `Dades`.

> faig un txt amb una UO de prova. Executo el script dos cops i miro les dues ultimes linies del log. El primer cop la crea i el segon diu que ja existeix.

```powershell
PS C:\Users\Administrador> $txt = '.\prova_uo.txt'
PS C:\Users\Administrador> 'OU=ProvaLogUO,OU=MusicCloud,DC=musiccloud,DC=local' | Set-Content $txt
PS C:\Users\Administrador> .\crear_uos_fitxer.ps1 -fitxer $txt
Creada: ProvaLogUO
PS C:\Users\Administrador> .\crear_uos_fitxer.ps1 -fitxer $txt
Ja existeix: ProvaLogUO
PS C:\Users\Administrador> Get-Content .\Dades\uos.log -Tail 2
2026-11-17 16:16:54 [INFO] Creada: ProvaLogUO | OU=MusicCloud,DC=musiccloud,DC=local
2026-11-17 16:16:55 [INFO] Ja existeix: ProvaLogUO | OU=MusicCloud,DC=musiccloud,DC=local
```

> ara poso una ruta que no existeix per veure si l'error queda al `.err`.

```powershell
PS C:\Users\Administrador> 'OU=ProvaLogUO,OU=NoExisteixProva,DC=musiccloud,DC=local' | Set-Content $txt
PS C:\Users\Administrador> try { .\crear_uos_fitxer.ps1 -fitxer $txt } catch { $_.Exception.Message }
No se encuentra el objeto de directorio
PS C:\Users\Administrador> Select-String -Path .\Dades\uos.err -SimpleMatch '[ERR]' | Select-Object -Last 1 -ExpandProperty Line
C:\Users\Administrador\crear_uos_fitxer.ps1 : 2026-11-17 16:16:55 [ERR] No se encuentra el objeto
```

> borro el txt i torno a executar el script. Ha de sortir l'avis i quedar al `.warn`.

```powershell
PS C:\Users\Administrador> Remove-Item $txt
PS C:\Users\Administrador> .\crear_uos_fitxer.ps1 -fitxer $txt
No trobo el fitxer: .\prova_uo.txt
PS C:\Users\Administrador> Get-Content .\Dades\uos.warn -Tail 1
2026-11-17 16:16:56 [WARN] No trobo el fitxer: .\prova_uo.txt
```

> al final he borrat la UO de prova.
