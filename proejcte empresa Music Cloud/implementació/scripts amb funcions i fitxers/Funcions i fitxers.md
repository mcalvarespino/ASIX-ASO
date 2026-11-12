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
