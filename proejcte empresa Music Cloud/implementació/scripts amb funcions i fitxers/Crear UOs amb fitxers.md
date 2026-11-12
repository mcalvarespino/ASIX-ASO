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
