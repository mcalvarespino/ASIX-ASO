# Exercici 7 amb funcions

> he fet el mateix que al crear_uo_07. Li passo el nom, la ruta i la llista de filles. Si alguna UO ja existeix, la deixa com esta.

Script: [crear_uo_07.ps1](scripts/crear_uo_07.ps1)

> la funcio Preparar-UO busca la UO i la crea si falta. Retorna la UO i si l'ha creat. Els missatges de Creada i Ja existeix els fico al programa principal, com diu la regla.

> primer comprovo la ruta. Despres el foreach passa per la principal i per les filles. Quan ja tinc la principal, faig servir la seva ruta per posar-hi les filles.

## Prova al Core

> per provar el script he fet servir una UO temporal amb Clients i Servidors. L'he executat dues vegades amb els mateixos noms.

```powershell
PS C:\Users\Administrador> $f = Join-Path $env:TEMP 'crear_uo_07_funcions_4867.ps1'
PS C:\Users\Administrador> & $f -nomOU ProvaFuncions4867 -descendents Clients,Servidors
Creada: ProvaFuncions4867
Creada: Clients
Creada: Servidors
PS C:\Users\Administrador> & $f -nomOU ProvaFuncions4867 -descendents Clients,Servidors
Ja existeix: ProvaFuncions4867
Ja existeix: Clients
Ja existeix: Servidors
```

> ara comprovo que les dues filles estan dins de la principal i que avisa si la ruta no existeix.

```powershell
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "OU=ProvaFuncions4867,DC=musiccloud,DC=local" -SearchScope OneLevel | Select-Object -ExpandProperty Name
Clients
Servidors
PS C:\Users\Administrador> & $f -nomOU ProvaFuncions4867 -ruta "OU=NoExisteix,DC=musiccloud,DC=local" -descendents Clients
No puc accedir a la ruta: OU=NoExisteix,DC=musiccloud,DC=local
```

> la segona execucio no ha duplicat res. En acabar he eliminat les UO i el fitxer temporal de la prova.
