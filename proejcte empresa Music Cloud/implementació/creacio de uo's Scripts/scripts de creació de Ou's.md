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

## 4. L'ordre dels arguments no importa

> parteixo del tercer i canvio els args per param, com a l'exemple del profe. Ara els arguments tenen nom.

Script: [crear_uo_04.ps1](../scripts/crear_uo_04.ps1)

```powershell
param (
    [string]$nomOU,
    [string]$ruta
)
```

> per comprovar-ho executarem el script amb els dos ordres:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_04.ps1 -nomOU ProvaOrdre -ruta "OU=ProvesScripts,DC=musiccloud,DC=local"
Creada: ProvaOrdre
PS C:\Users\Administrador> .\scripts\crear_uo_04.ps1 -ruta "OU=ProvesScripts,DC=musiccloud,DC=local" -nomOU ProvaOrdre
Ja existeix: ProvaOrdre
PS C:\Users\Administrador>
```

> funciona amb els dos ordres. A la segona execucio detecta la mateixa UO i no la duplica.

## 5. Nom obligatori i ruta per defecte

> modifico el quart posant el nom obligatori. Si no passo ruta, fa servir el domini musiccloud.local.

Script: [crear_uo_05.ps1](../scripts/crear_uo_05.ps1)

```powershell
param (
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [string]$ruta = "DC=musiccloud,DC=local"
)
```

> per provar la ruta per defecte i el nom obligatori ficarem aquestes comandes:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_05.ps1 -nomOU MusicCloud
Ja existeix: MusicCloud
PS C:\Users\Administrador> .\scripts\crear_uo_05.ps1

cmdlet crear_uo_05.ps1 en la posición 1 de la canalización de comandos
Proporcione valores para los parámetros siguientes:
nomOU: ProvaNomObligatori
Creada: ProvaNomObligatori
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Identity "OU=ProvaNomObligatori,DC=musiccloud,DC=local" | Select-Object Name,DistinguishedName | Format-List

Name              : ProvaNomObligatori
DistinguishedName : OU=ProvaNomObligatori,DC=musiccloud,DC=local

PS C:\Users\Administrador>
```

> si no escric el nom, el demana. La UO s'ha creat directament al domini perquè no he passat cap ruta.

## 6. Comprovar els casos abans de crear

> parteixo del cinque i afegeixo comprovacions del nom i la ruta. Si alguna cosa no esta be mostra un missatge i s'atura.

Script: [crear_uo_06.ps1](../scripts/crear_uo_06.ps1)

> faig servir Get-ADObject per comprovar la ruta, perquè pot ser el domini o una UO. Despres busco el nom nomes dins d'aquella ruta.

> per comprovar els casos ficarem aquestes comandes:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU ProvaValidacio -ruta "OU=ProvesScripts,DC=musiccloud,DC=local"
Creada: ProvaValidacio
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU ProvaValidacio -ruta "OU=ProvesScripts,DC=musiccloud,DC=local"
Ja existeix: ProvaValidacio
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU Prova -ruta "OU=NoExisteix,DC=musiccloud,DC=local"
No puc accedir a la ruta: OU=NoExisteix,DC=musiccloud,DC=local
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU " "
El nom i la ruta no poden estar buits.
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU "OU=Prova"
Escriu nomes el nom, sense OU=.
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU Prova -ruta "CN=Users,DC=musiccloud,DC=local"
La ruta ha de ser el domini o una UO.
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU MusicCloud
Ja existeix: MusicCloud
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU Prova -ruta " "
El nom i la ruta no poden estar buits.
PS C:\Users\Administrador>
```

> crea la UO quan toca, no la duplica i controla les dades incorrectes sense treure un error llarg de PowerShell. El nom es passa sense OU=.
