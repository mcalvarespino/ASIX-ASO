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

## 6. Comprovar la ruta i crear nomes si falta

> parteixo del cinque. Primer comprovo que la ruta existeix i que es el domini o una UO. Despres miro el nom i nomes creo la UO si no existeix.

Script: [crear_uo_06.ps1](../scripts/crear_uo_06.ps1)

> per provar que es pot repetir ficarem aquestes comandes:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU ProvaSimple -ruta "OU=ProvesScripts,DC=musiccloud,DC=local"
Creada: ProvaSimple
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU ProvaSimple -ruta "OU=ProvesScripts,DC=musiccloud,DC=local"
Ja existeix: ProvaSimple
PS C:\Users\Administrador>
```

> ara provo una ruta que no existeix i noms incorrectes. Si fallen la ruta i el nom, primer avisa de la ruta:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU " " -ruta "OU=NoExisteix,DC=musiccloud,DC=local"
No puc accedir a la ruta: OU=NoExisteix,DC=musiccloud,DC=local
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU " "
Escriu nomes el nom, sense OU= i sense deixar-lo buit.
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU "OU=Prova"
Escriu nomes el nom, sense OU= i sense deixar-lo buit.
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU Prova -ruta "CN=Users,DC=musiccloud,DC=local"
La ruta ha de ser el domini o una UO.
PS C:\Users\Administrador> .\scripts\crear_uo_06.ps1 -nomOU Prova -ruta " "
No puc accedir a la ruta:
PS C:\Users\Administrador>
```

> es idempotent: si el torno a executar no duplica la UO.

## 7. Crear la UO i les seves filles

> es el mateix script del sise amb un parametre descendents i un foreach al final. Primer comprova la ruta i crea la UO nomes si falta. Despres fa el mateix amb cada filla.

Script: [crear_uo_07.ps1](../scripts/crear_uo_07.ps1)

> els noms de les filles es passen com una llista, no estan escrits dins del script. Per provar-ho agafo els noms que ja tenim a MusicCloud:

```powershell
PS C:\Users\Administrador> $departaments = Get-ADOrganizationalUnit -Filter * -SearchBase "OU=Usuaris,OU=MusicCloud,DC=musiccloud,DC=local" -SearchScope OneLevel | Select-Object -ExpandProperty Name
PS C:\Users\Administrador> $tipusEquips = Get-ADOrganizationalUnit -Filter * -SearchBase "OU=Equips,OU=MusicCloud,DC=musiccloud,DC=local" -SearchScope OneLevel | Select-Object -ExpandProperty Name
PS C:\Users\Administrador> .\scripts\crear_uo_07.ps1 -nomOU Usuaris -ruta "OU=ProvesScripts,DC=musiccloud,DC=local" -descendents $departaments
Creada: Usuaris
Creada: Administracio
Creada: Comercial
Creada: Desenvolupament
Creada: Direccio
Creada: Sistemes
PS C:\Users\Administrador> .\scripts\crear_uo_07.ps1 -nomOU Equips -ruta "OU=ProvesScripts,DC=musiccloud,DC=local" -descendents $tipusEquips
Creada: Equips
Creada: Clients
Creada: Servidors
PS C:\Users\Administrador>
```

> ara repeteixo les comandes canviant l'ordre dels parametres per comprovar que no duplica res:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_07.ps1 -ruta "OU=ProvesScripts,DC=musiccloud,DC=local" -nomOU Usuaris -descendents $departaments
Ja existeix: Usuaris
Ja existeix: Administracio
Ja existeix: Comercial
Ja existeix: Desenvolupament
Ja existeix: Direccio
Ja existeix: Sistemes
PS C:\Users\Administrador> .\scripts\crear_uo_07.ps1 -ruta "OU=ProvesScripts,DC=musiccloud,DC=local" -nomOU Equips -descendents $tipusEquips
Ja existeix: Equips
Ja existeix: Clients
Ja existeix: Servidors
PS C:\Users\Administrador>
```

> tambe comprovo que primer miri la ruta encara que els noms estiguin buits:

```powershell
PS C:\Users\Administrador> .\scripts\crear_uo_07.ps1 -nomOU " " -ruta "OU=NoExisteix,DC=musiccloud,DC=local" -descendents " "
No puc accedir a la ruta: OU=NoExisteix,DC=musiccloud,DC=local
PS C:\Users\Administrador>
```

> els set scripts es poden repetir sense duplicar les UO. Els cinc primers tambe els he executat dues vegades directament al Core.

### Comprovacio final

> he eliminat les UO temporals de les proves i he comprovat que les 11 UO de MusicCloud segueixen creades:

```powershell
PS C:\Users\Administrador> Get-ADOrganizationalUnit -Filter * -SearchBase "OU=MusicCloud,DC=musiccloud,DC=local" | Measure-Object | Select-Object Count

Count
-----
   11

PS C:\Users\Administrador>
```
