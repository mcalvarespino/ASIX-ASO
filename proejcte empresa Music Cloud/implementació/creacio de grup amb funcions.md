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

## Com estan les UO

> al Core ja hi ha Grups i esta buida. Dins de MusicCloud falten Servidors i Comptes_de_servei. A Usuaris hi ha les UO dels departaments i falten Interns i Externs. A Equips hi ha Clients i Servidors, pero al disseny Servidors va al costat d'Equips.

> quan toqui afegir les UO que falten fare servir el 7 amb funcions.

## Proves al Core

> espero que digui que falta GG_Direccio. Si li passo una ruta que no existeix, espero que avisi i pari.

```powershell
PS C:\Users\Administrador> .\crear_grups.ps1 -nomGrup GG_Direccio
Falta crear: GG_Direccio
PS C:\Users\Administrador> .\crear_grups.ps1 -nomGrup GG_Direccio -ruta 'OU=NoExisteix,DC=musiccloud,DC=local'
No puc accedir a la UO: OU=NoExisteix,DC=musiccloud,DC=local
```
