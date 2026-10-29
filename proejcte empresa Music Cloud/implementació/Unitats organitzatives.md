# Enunciat

## Objectiu

Crear l’estructura inicial d’unitats organitzatives del domini `musiccloud.local`.
## Escenari

MusicCloud ja disposa del domini:
```text
musiccloud.local
```
El servidor `SRV-AD-01` ja és controlador de domini.

Ara cal crear una estructura d’unitats organitzatives que permeti organitzar els objectes de l’empresa.
## Estructura que cal crear

Creeu l’estructura següent:
```text
musiccloud.local
└── MusicCloud
    ├── Usuaris
    │   ├── Administracio
    │   ├── Comercial
    │   ├── Desenvolupament
    │   ├── Sistemes
    │   └── Direccio
    ├── Equips
    │   ├── Clients
    │   └── Servidors
    └── Grups
```
## Part 1. Creació de la UO principal

Creeu una unitat organitzativa principal anomenada:
```text
MusicCloud
```
Aquesta UO serà el contenidor principal de l’estructura de l’empresa.

> per crear la UO principal ficarem la següent comanda:

```powershell
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "MusicCloud" -Path "DC=musiccloud,DC=local"
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Identity "OU=MusicCloud,DC=musiccloud,DC=local" | Select-Object Name,DistinguishedName

Name       DistinguishedName
----       -----------------
MusicCloud OU=MusicCloud,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> aqui es veu que MusicCloud ja esta creada dins del domini.

## Part 2. Creació de les UO de primer nivell

Dins de la UO `MusicCloud`, creeu les UO següents:
```text
Usuaris
Equips
Grups
```

> per crear les UO de primer nivell ficarem aquestes comandes:

```powershell
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Usuaris" -Path "OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Equips" -Path "OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Grups" -Path "OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "OU=MusicCloud,DC=musiccloud,DC=local" -SearchScope OneLevel | Select-Object Name,DistinguishedName | Format-List

Name              : Equips
DistinguishedName : OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Grups
DistinguishedName : OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Usuaris
DistinguishedName : OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> aqui es veu que les tres estan dins de MusicCloud.

## Part 3. Creació de les UO de departaments

Dins de la UO `Usuaris`, creeu les UO següents:
```text
Administracio
Comercial
Desenvolupament
Sistemes
Direccio
```

> per crear els departaments dins d'Usuaris ficarem les següents comandes:

```powershell
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Administracio" -Path "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Comercial" -Path "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Desenvolupament" -Path "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Sistemes" -Path "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Direccio" -Path "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local" -SearchScope OneLevel | Select-Object Name,DistinguishedName | Format-List

Name              : Administracio
DistinguishedName : OU=Administracio,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=
                    local

Name              : Comercial
DistinguishedName : OU=Comercial,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=loca
                    l

Name              : Desenvolupament
DistinguishedName : OU=Desenvolupament,OU=Usuaris,OU=MusicCloud,DC=musiccloud,D
                    C=local

Name              : Direccio
DistinguishedName : OU=Direccio,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Sistemes
DistinguishedName : OU=Sistemes,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> aqui surten els cinc departaments dins d'Usuaris.

## Part 4. Creació de les UO d’equips

Dins de la UO `Equips`, creeu les UO següents:
```text
Clients
Servidors
```

> per separar els clients dels servidors ficarem aquestes comandes dins d'Equips:

```powershell
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Clients" -Path "OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> New-ADOrganizationalUnit -Name "Servidors" -Path "OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local"
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local" -SearchScope OneLevel | Select-Object Name,DistinguishedName | Format-List

Name              : Clients
DistinguishedName : OU=Clients,OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Servidors
DistinguishedName : OU=Servidors,OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> les dues UO ja estan creades dins d'Equips.

## Part 5. Verificació

Executeu una consulta que mostri totes les unitats organitzatives del domini.

La sortida ha de mostrar, com a mínim, les UO creades en aquesta pràctica.

> per veure totes les UO del domini ficarem la següent comanda:

```powershell
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "DC=musiccloud,DC=local" | Select-Object Name,DistinguishedName | Format-List

Name              : Domain Controllers
DistinguishedName : OU=Domain Controllers,DC=musiccloud,DC=local

Name              : MusicCloud
DistinguishedName : OU=MusicCloud,DC=musiccloud,DC=local

Name              : Usuaris
DistinguishedName : OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Equips
DistinguishedName : OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Grups
DistinguishedName : OU=Grups,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Administracio
DistinguishedName : OU=Administracio,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=
                    local

Name              : Comercial
DistinguishedName : OU=Comercial,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=loca
                    l

Name              : Desenvolupament
DistinguishedName : OU=Desenvolupament,OU=Usuaris,OU=MusicCloud,DC=musiccloud,D
                    C=local

Name              : Sistemes
DistinguishedName : OU=Sistemes,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Direccio
DistinguishedName : OU=Direccio,OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Clients
DistinguishedName : OU=Clients,OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local

Name              : Servidors
DistinguishedName : OU=Servidors,OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> aqui es veuen les 11 UO que hem creat. Tambe surt Domain Controllers, que ja estava creada abans.

## Part 6. Preguntes

Responeu breument:

1. Per què és útil crear una UO principal anomenada `MusicCloud`?

> perquè tota l'estructura de l'empresa quedi junta i sigui mes facil d'organitzar.

2. Per què se separen `Usuaris`, `Equips` i `Grups`?

> perquè son objectes diferents i aixi els podem administrar i aplicar politiques per separat.

3. Per què els departaments s'han creat dins de `Usuaris`?

> perquè aixi podem separar els usuaris segons el departament on treballen.

4. Per què no és recomanable deixar tots els usuaris dins del contenidor `Users`?

> perquè quedarien tots barrejats i no podem enllaçar GPO directament a Users com en una UO.

## Part 7. Creació scripts

- 7.1. Crea un script per eliminar totes les OUs creades en la pràctica
- 7.2. Crea un script que crei l'OU principal (musiccloud).
- 7.3. Crea un script que crei l'OU principal i les OUs descendents: Usuaris, Equips i Grups
- 7.4. Crea un script que creï l'OU principal si no existeix i que creï únicament les UO descendents que encara no existeixin. El script s'ha de poder executar més d'una vegada sense generar errors ni duplicar objectes.

### 7.1. Eliminar les UO

> per eliminar les UO de la practica farem servir aquest script. Treu la proteccio de MusicCloud i elimina les UO de dins. Si hi ha altres objectes, s'atura.

Script: [7_1_eliminar_uo.ps1](scripts/7_1_eliminar_uo.ps1)

```powershell
PS C:\Users\Administrador> .\scripts\7_1_eliminar_uo.ps1
UO MusicCloud i descendents eliminades.
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter "Name -eq 'MusicCloud'" -SearchBase "DC=musiccloud,DC=local" -SearchScope OneLevel | Measure-Object | Select-Object Count

Count
-----
    0

PS C:\Users\Administrador>
```

> el resultat es 0, per tant MusicCloud ja no existeix. Als següents punts la tornare a crear.

### 7.2. Crear la UO principal

> per crear nomes MusicCloud ficarem aquest script. El nom i la ruta estan guardats en variables, com als apunts.

Script: [7_2_crear_principal.ps1](scripts/7_2_crear_principal.ps1)

```powershell
PS C:\Users\Administrador> .\scripts\7_2_crear_principal.ps1
UO MusicCloud creada.
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Identity "OU=MusicCloud,DC=musiccloud,DC=local" | Select-Object Name,DistinguishedName

Name       DistinguishedName
----       -----------------
MusicCloud OU=MusicCloud,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> MusicCloud ja torna a estar creada.

### 7.3. Crear MusicCloud i les UO de primer nivell

> per fer aixo farem servir aquest script, que crea MusicCloud i despres recorre els tres noms amb un foreach.

Script: [7_3_crear_estructura.ps1](scripts/7_3_crear_estructura.ps1)

> per provar-lo des de zero primer he eliminat la UO del punt anterior:

```powershell
PS C:\Users\Administrador> .\scripts\7_1_eliminar_uo.ps1
UO MusicCloud i descendents eliminades.
PS C:\Users\Administrador> .\scripts\7_3_crear_estructura.ps1
UO MusicCloud creada.
UO Usuaris creada.
UO Equips creada.
UO Grups creada.
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "OU=MusicCloud,DC=musiccloud,DC=local" | Select-Object Name

Name
----
MusicCloud
Usuaris
Equips
Grups

PS C:\Users\Administrador>
```

> aqui es veu que ha creat les quatre UO.
