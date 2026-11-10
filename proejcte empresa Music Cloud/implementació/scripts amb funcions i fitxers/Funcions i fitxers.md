# Funcions i fitxers

## Llegir el fitxer de servidors

> he fet una primera prova amb fitxers. A Dades/servers.txt hi he posat un servidor per linia, com als apunts.

> la funcio Llegir-Servidors llegeix el fitxer amb Get-Content. Al programa principal faig un foreach per numerar i mostrar els noms.

[Script de prova](scripts%20proves/llegir_servers.ps1) · [Fitxer de dades](scripts%20proves/Dades/servers.txt)

## Prova al Core

> espero que surtin els tres servidors numerats i en el mateix ordre que al fitxer.

```powershell
PS> .\llegir_servers.ps1
1 SRVADDS
2 SRVWEB
3 SRVMAIL
```
