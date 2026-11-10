# Creació de grups amb funcions

> he començat pel mateix que al 7. Primer miro si la UO existeix i despres busco el grup. Per defecte busca a Grups dins de MusicCloud. La funcio nomes fa la cerca i el missatge surt al programa principal.

[crear_grups.ps1](scripts%20amb%20funcions/crear_grups.ps1)

## Grups que toquen

> del disseny he tret aquests 11 grups inicials. Tots van dins de Grups.

- Departaments: `GG_Direccio`, `GG_Administracio`, `GG_Suport_Tecnic`, `GG_Produccio_Musical` i `GG_Informatica`.
- Externs i caps: `GG_Externs` i `GG_Caps_Departament`.
- Projectes: `GG_Campanya_Estiu`, `GG_Nou_Cataleg` i `GG_Migracio_Servidors`.
- Administració: `GG_Admins_Sistema`.

> els grups de permisos, com GP_Administracio_Gestio_LE, els deixo per la part de permisos.


## Afegir les UO que falten

> he fet servir el 7 amb funcions que ja tenia. Espero que crei Servidors i Comptes_de_servei dins de MusicCloud, i Interns i Externs dins d'Usuaris. Si repeteixo les comandes, han de sortir totes com a existents.

```powershell
PS C:\Users\Administrador> $f = Join-Path $env:TEMP 'crear_uo_07.ps1'
PS C:\Users\Administrador> $base = 'OU=MusicCloud,DC=musiccloud,DC=local'
PS C:\Users\Administrador> & $f -nomOU MusicCloud -descendents Servidors,Comptes_de_servei
Ja existeix: MusicCloud
Creada: Servidors
Creada: Comptes_de_servei
PS C:\Users\Administrador> & $f -nomOU Usuaris -ruta $base -descendents Interns,Externs
Ja existeix: Usuaris
Creada: Interns
Creada: Externs
PS C:\Users\Administrador> & $f -nomOU MusicCloud -descendents Servidors,Comptes_de_servei
Ja existeix: MusicCloud
Ja existeix: Servidors
Ja existeix: Comptes_de_servei
PS C:\Users\Administrador> & $f -nomOU Usuaris -ruta $base -descendents Interns,Externs
Ja existeix: Usuaris
Ja existeix: Interns
Ja existeix: Externs
```


## prova al Core

> espero que digui que falta GG_Direccio. Si li passo una ruta que no existeix, espero que avisi i pari.

```powershell
PS C:\Users\Administrador> .\crear_grups.ps1 -nomGrup GG_Direccio
Falta crear: GG_Direccio
PS C:\Users\Administrador> .\crear_grups.ps1 -nomGrup GG_Direccio -ruta 'OU=NoExisteix,DC=musiccloud,DC=local'
No puc accedir a la UO: OU=NoExisteix,DC=musiccloud,DC=local
```

## Crear el primer grup

> ara he afegit Crear-Grup. Buscar-Grup busca i Crear-Grup crea. Si el grup ja hi es, el programa principal ho diu i no el torna a crear.

> espero que a la primera passada crei GG_Direccio i que a la segona digui que ja existeix. Amb Get-ADGroup comprovo que es un grup de seguretat global dins de Grups.

```powershell
PS C:\Users\Administrador> $f = Join-Path $env:TEMP 'crear_grups.ps1'
PS C:\Users\Administrador> & $f -nomGrup GG_Direccio
Creat: GG_Direccio
PS C:\Users\Administrador> & $f -nomGrup GG_Direccio
Ja existeix: GG_Direccio
PS C:\Users\Administrador> Get-ADGroup -Identity GG_Direccio -ErrorAction Stop | Format-List Name,GroupScope,GroupCategory,DistinguishedName

Name              : GG_Direccio
GroupScope        : Global
GroupCategory     : Security
DistinguishedName : CN=GG_Direccio,OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local
```

## Crear diversos grups

> ara passo els noms amb -nomGrup separats per comes. Comprovo els noms i creo els grups que falten. Les funcions segueixen fent una feina cadascuna i els missatges surten al programa principal.

> espero que la primera vegada crei els deu que falten i deixi GG_Direccio com esta. A la segona espero que digui que ja existeixen tots.

```powershell
PS C:\Users\Administrador> $f = Join-Path $env:TEMP 'crear_grups.ps1'
PS C:\Users\Administrador> & $f -nomGrup GG_Direccio,GG_Administracio,GG_Suport_Tecnic,GG_Produccio_Musical,GG_Informatica,GG_Externs,GG_Caps_Departament,GG_Campanya_Estiu,GG_Nou_Cataleg,GG_Migracio_Servidors,GG_Admins_Sistema
Ja existeix: GG_Direccio
Creat: GG_Administracio
Creat: GG_Suport_Tecnic
Creat: GG_Produccio_Musical
Creat: GG_Informatica
Creat: GG_Externs
Creat: GG_Caps_Departament
Creat: GG_Campanya_Estiu
Creat: GG_Nou_Cataleg
Creat: GG_Migracio_Servidors
Creat: GG_Admins_Sistema
PS C:\Users\Administrador> & $f -nomGrup GG_Direccio,GG_Administracio,GG_Suport_Tecnic,GG_Produccio_Musical,GG_Informatica,GG_Externs,GG_Caps_Departament,GG_Campanya_Estiu,GG_Nou_Cataleg,GG_Migracio_Servidors,GG_Admins_Sistema
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

> he mirat amb Get-ADGroup que dins de Grups hi ha els 11 grups i que tots son Global i Security.

## Prova final al Core

> provo la copia que tinc al Core amb dos grups que ja existeixen. Espero que ho digui les dues vegades. Amb una UO incorrecta espero que avisi i pari.

```powershell
PS C:\Users\Administrador> $f = 'C:\Users\Administrador\crear_grups.ps1'
PS C:\Users\Administrador> & $f -nomGrup GG_Direccio,GG_Informatica
Ja existeix: GG_Direccio
Ja existeix: GG_Informatica
PS C:\Users\Administrador> & $f -nomGrup GG_Direccio,GG_Informatica
Ja existeix: GG_Direccio
Ja existeix: GG_Informatica
PS C:\Users\Administrador> & $f -nomGrup GG_Direccio -ruta 'OU=NoExisteix,DC=musiccloud,DC=local'
No puc accedir a la UO: OU=NoExisteix,DC=musiccloud,DC=local
```

> he comparat els grups de la UO Grups abans i despres. Hi havia els mateixos 12 objectes i la prova no n'ha creat ni eliminat cap.
