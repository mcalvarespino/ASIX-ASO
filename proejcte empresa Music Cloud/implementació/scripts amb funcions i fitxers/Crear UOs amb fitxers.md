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
