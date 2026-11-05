# Creació de grups amb funcions

> he començat pel mateix que al 7. Primer miro si la UO existeix i despres busco el grup. Per defecte busca a Grups dins de MusicCloud. La funcio nomes fa la cerca i el missatge surt al programa principal.

[crear_grups.ps1](scripts%20amb%20funcions/crear_grups.ps1)

## Grups que toquen

> del disseny he tret aquests 11 grups inicials. Tots van dins de Grups. Tots els noms comencen per GG_ i despres porten el nom del grup, com GG_Informatica.

- Departaments: `GG_Direccio`, `GG_Administracio`, `GG_Suport_Tecnic`, `GG_Produccio_Musical` i `GG_Informatica`.
- Externs i caps: `GG_Externs` i `GG_Caps_Departament`.
- Projectes: `GG_Campanya_Estiu`, `GG_Nou_Cataleg` i `GG_Migracio_Servidors`.
- Administració: `GG_Admins_Sistema`.

> els grups de permisos, com GP_Administracio_Gestio_LE, els deixo per la part de permisos.

## Com estan les UO

> quan vaig començar, Grups ja existia i estava buida. Dins de MusicCloud falten Servidors i Comptes_de_servei. A Usuaris hi ha les UO dels departaments i falten Interns i Externs. A Equips hi ha Clients i Servidors, pero al disseny Servidors va al costat d'Equips.

> quan toqui afegir les UO que falten fare servir el 7 amb funcions.

## Primera prova al Core

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

> tambe he comprovat en local que Informatica i GG_ es rebutgen, i que GG_Direccio passa la comprovacio.
