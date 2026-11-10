# Exercici 7 amb funcions

> he fet el mateix que al crear_uo_07. Li passo el nom, la ruta i la llista de filles. Si alguna UO ja existeix, la deixa com esta.

Script: [crear_uo_07.ps1](scripts/crear_uo_07.ps1)

> Buscar-UO nomes busca una UO i Crear-UO nomes la crea. Les dues retornen el resultat. Els missatges els fico al programa principal.

> primer comprovo la ruta. Despres el foreach passa per la principal i per les filles. Quan ja tinc la principal, faig servir la seva ruta per posar-hi les filles.

## Proves al Core

| Prova | Resultat esperat |
| --- | --- |
| Primera execucio | Es crea la UO principal amb Clients i Servidors. |
| Segona execucio amb els mateixos arguments | Les tres UO ja existeixen i el script no en crea cap mes. |
| Consulta de les filles | Dins de la principal surten Clients i Servidors. |
| Ruta inexistent | El script avisa i s'atura abans de crear res. |

### Comandes i sortida real

> per provar el script he fet servir una UO temporal amb Clients i Servidors. L'he executat dues vegades amb els mateixos noms.

```powershell
PS C:\Users\Administrador> $f = Join-Path $env:TEMP 'crear_uo_07_regles_4968.ps1'
PS C:\Users\Administrador> & $f -nomOU ProvaFuncions4968 -descendents Clients,Servidors
Creada: ProvaFuncions4968
Creada: Clients
Creada: Servidors
PS C:\Users\Administrador> & $f -nomOU ProvaFuncions4968 -descendents Clients,Servidors
Ja existeix: ProvaFuncions4968
Ja existeix: Clients
Ja existeix: Servidors
```

> ara comprovo que les dues filles estan dins de la principal i que avisa si la ruta no existeix.

```powershell
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "OU=ProvaFuncions4968,DC=musiccloud,DC=local" -SearchScope OneLevel | Select-Object -ExpandProperty Name
Clients
Servidors
PS C:\Users\Administrador> & $f -nomOU ProvaFuncions4968 -ruta "OU=NoExisteix,DC=musiccloud,DC=local" -descendents Clients
No puc accedir a la ruta: OU=NoExisteix,DC=musiccloud,DC=local
```

> la segona execucio no ha duplicat res. En acabar he eliminat les UO i el fitxer temporal de la prova.
