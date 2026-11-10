# Funcions i fitxers

## Llegir el fitxer de servidors

> he fet una primera prova amb fitxers. He ficat un servidor per linia al servers.txt com als apunts.

> amb Get-Content llegeixo el txt i amb un foreach mostro els noms amb el seu numero.

[Script de prova](scripts%20proves/llegir_servers.ps1) · [Fitxer de dades](scripts%20proves/Dades/servers.txt)

## Prova al Core

> per provar-ho al Core executo el script i han de sortir els 3 servidors numerats en el mateix ordre.

```powershell
PS> .\llegir_servers.ps1
1 SRVADDS
2 SRVWEB
3 SRVMAIL
```

## Preparar el TXT de les UO

> primer he ficat les 8 UO que toquen al ous.txt. He ficat la ruta sencera a cada linia i les he ordenat perquè primer surti la UO de fora i despres les que van a dins.

[Fitxer de les UO](Dades/ous.txt)

> per comprovar que el fitxer es llegeix be fico aquesta comanda al Core. Han de sortir les 8 rutes tal com les he ficat.

```powershell
PS> Get-Content -LiteralPath .\Dades\ous.txt
OU=MusicCloud,DC=musiccloud,DC=local
OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local
OU=Interns,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local
OU=Externs,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local
OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local
OU=Servidors,OU=MusicCloud,DC=musiccloud,DC=local
OU=Comptes_de_servei,OU=MusicCloud,DC=musiccloud,DC=local
```

## Llegir el txt i separar el nom de la ruta

> ara he fet el crear_ous.ps1. La funcio llegeix el txt i al foreach tallo cada linia per la primera coma. Trec OU= del nom i la resta es la ruta on ha d'anar.

[Script](crear_ous.ps1)

> ho provo al Core. Han de sortir les 8 UO amb el nom i la ruta separats. En aquest pas nomes les mostro.

```powershell
PS> .\crear_ous.ps1
MusicCloud -> DC=musiccloud,DC=local
Usuaris -> OU=MusicCloud,DC=musiccloud,DC=local
Interns -> OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local
Externs -> OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local
Grups -> OU=MusicCloud,DC=musiccloud,DC=local
Equips -> OU=MusicCloud,DC=musiccloud,DC=local
Servidors -> OU=MusicCloud,DC=musiccloud,DC=local
Comptes_de_servei -> OU=MusicCloud,DC=musiccloud,DC=local
```

## Crear les UO que falten

> ara he afegit Buscar-UO i Crear-UO. Una busca la UO i l'altra la crea. Els missatges els fico al foreach del programa principal. Primer faig un Test-Path per mirar que hi hagi el txt.

> aquestes proves les vaig fer amb una copia que llegia el txt de la seva carpeta.

> amb el txt del disseny espero que surtin les 8 UO com a existents perquè ja hi son al Core.

```powershell
PS> .\crear_ous.ps1
Ja existeix: MusicCloud
Ja existeix: Usuaris
Ja existeix: Interns
Ja existeix: Externs
Ja existeix: Grups
Ja existeix: Equips
Ja existeix: Servidors
Ja existeix: Comptes_de_servei
```

> per provar que crea les que falten, en una copia de prova he ficat una UO i una filla al txt. A la primera han de sortir com a creades. A la segona han de sortir com a existents.

```powershell
PS> $base = 'OU=ProvaFitxersOU,DC=musiccloud,DC=local'
PS> $filla = "OU=Filla,$base"
PS> $base,$filla | Set-Content -LiteralPath .\Dades\ous.txt
PS> .\crear_ous.ps1
Creada: ProvaFitxersOU
Creada: Filla
PS> .\crear_ous.ps1
Ja existeix: ProvaFitxersOU
Ja existeix: Filla
PS> Get-ADOrganizationalUnit -Identity $filla | Select-Object -ExpandProperty Name
Filla
```

> tambe trec el txt de la copia de prova per veure si avisa.

```powershell
PS> Remove-Item -LiteralPath .\Dades\ous.txt
PS> .\crear_ous.ps1
No trobo el fitxer ous.txt.
```

> al final he borrat les dues UO de prova del Core.

## Ruta del txt al Core

> ara he ficat la ruta sencera al crear_ous.ps1. Al Core el txt ha d'estar aqui.

```powershell
$fitxer = "C:\Users\Administrador\Dades\ous.txt"
```

> he ficat el txt i el script al Core. Al tornar-lo a executar espero que trobi les 8 UO.

```powershell
PS C:\Users\Administrador> & 'C:\Users\Administrador\crear_ous.ps1'
Ja existeix: MusicCloud
Ja existeix: Usuaris
Ja existeix: Interns
Ja existeix: Externs
Ja existeix: Grups
Ja existeix: Equips
Ja existeix: Servidors
Ja existeix: Comptes_de_servei
```

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
