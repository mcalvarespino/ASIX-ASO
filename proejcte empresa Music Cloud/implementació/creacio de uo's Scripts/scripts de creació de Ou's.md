# Scripts de creació de UO

> cada script parteix de l'anterior i vaig canviant el que demana cada punt.

## 1. Nom i ruta fixos

> primer faig el script amb el nom i la ruta en variables, com a l'exemple dels apunts. Si la UO ja existeix no la torna a crear.

Script: [crear_uo_01.ps1](../scripts/crear_uo_01.ps1)

```powershell
$nomOU = "MusicCloud"
$ruta = "DC=musiccloud,DC=local"
```

> per provar-lo ficarem la següent comanda:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_01.ps1
Ja existeix: MusicCloud
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Identity "OU=MusicCloud,DC=musiccloud,DC=local" | Select-Object Name

Name
----
MusicCloud

PS C:\Users\Administrador>
```

> MusicCloud ja estava creada de la practica anterior i el script la detecta.

## 2. Nom variable

> parteixo del primer i nomes canvio el nom per un argument. La ruta segueix fixa.

Script: [crear_uo_02.ps1](../scripts/crear_uo_02.ps1)

```powershell
$nomOU = $args[0]
$ruta = "DC=musiccloud,DC=local"
```

> per provar un altre nom ficarem aquesta comanda:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_02.ps1 ProvesScripts
Creada: ProvesScripts
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Identity "OU=ProvesScripts,DC=musiccloud,DC=local" | Select-Object Name,DistinguishedName

Name          DistinguishedName
----          -----------------
ProvesScripts OU=ProvesScripts,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> el nom ja no esta escrit dins del script, el passem quan l'executem. Farem servir aquesta UO per les proves següents.

## 3. Nom i ruta variables

> ara modifico el segon i tambe passo la ruta com a argument.

Script: [crear_uo_03.ps1](../scripts/crear_uo_03.ps1)

```powershell
$nomOU = $args[0]
$ruta = $args[1]
```

> per crear una UO dins de ProvesScripts ficarem aquesta comanda:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_03.ps1 ProvaRuta "OU=ProvesScripts,DC=musiccloud,DC=local"
Creada: ProvaRuta
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Identity "OU=ProvaRuta,OU=ProvesScripts,DC=musiccloud,DC=local" | Select-Object Name,DistinguishedName | Format-List

Name              : ProvaRuta
DistinguishedName : OU=ProvaRuta,OU=ProvesScripts,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> aqui es veu que l'ha creat a la ruta que li hem passat. En aquest script encara importa l'ordre: primer el nom i despres la ruta.
