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
