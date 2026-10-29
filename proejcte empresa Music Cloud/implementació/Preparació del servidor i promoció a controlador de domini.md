# Pràctica

## Objectiu

Preparar el servidor `SRV-AD-01` i promocionar-lo com a primer controlador de domini del domini `musiccloud.local`.
## Escenari

L’empresa **MusicCloud** vol iniciar la implantació d’Active Directory Domain Services.

El servidor Windows Server que s’utilitzarà com a controlador de domini serà:
```text
SRV-AD-01
```
El domini que es crearà serà:
```text
musiccloud.local
```
Aquest servidor també proporcionarà el servei DNS del domini.
## Tasques

### Part 1. Configuració inicial del servidor

Configureu el servidor perquè compleixi els requisits següents:

| Element           | Valor              |
| ----------------- | ------------------ |
| Nom del servidor  | `SRV-AD-01`        |
| Adreça IP         | fixa               |
| DNS preferit      | el mateix servidor |
| Connexió de xarxa | operativa          |
| Zona horària      | correcta           |
| Hora del sistema  | correcta           |
La configuració IP concreta dependrà de la xarxa del laboratori. Anoteu els valors utilitzats.

Completeu la taula següent:

| Paràmetre | Valor configurat |
| --- | --- |
| Adreça IP | 192.168.56.115 /24 |
| Màscara | 255.255.255.0 |
| Porta d’enllaç | Cap a Ethernet 2; 10.0.2.1 a la NAT |
| DNS preferit | 192.168.56.115 |
| Nom del servidor | SRV-AD-01 |

> He deixat les IP fixes i he canviat el nom del servidor. Per l’AD faig servir la 192, la NAT queda per sortir a Internet.

```powershell
PS C:\Users\Administrador> Set-NetIPInterface -InterfaceIndex 7 -Dhcp Disabled
PS C:\Users\Administrador> New-NetIPAddress -InterfaceIndex 7 -IPAddress 10.0.2.15 -PrefixLength 24 -DefaultGateway 10.0.2.1
PS C:\Users\Administrador> Set-NetIPInterface -InterfaceIndex 4 -Dhcp Disabled
PS C:\Users\Administrador> New-NetIPAddress -InterfaceIndex 4 -IPAddress 192.168.56.115 -PrefixLength 24
PS C:\Users\Administrador> Set-DnsClientServerAddress -InterfaceIndex 4,7 -ServerAddresses 192.168.56.115
PS C:\Users\Administrador> Set-DnsClient -InterfaceIndex 7 -RegisterThisConnectionsAddress $false
PS C:\Users\Administrador> Rename-Computer -NewName SRV-AD-01 -Force -PassThru
```

> Després del reinici he comprovat que el nom i les IP estan bé. El primer intent s’havia parat en treure DHCP, però ja ha quedat corregit.

```powershell
PS C:\Users\Administrador> hostname
SRV-AD-01

PS C:\Users\Administrador> Get-NetIPAddress -AddressFamily IPv4 | Format-Table InterfaceAlias,IPAddress,PrefixLength,PrefixOrigin
InterfaceAlias              IPAddress      PrefixLength PrefixOrigin
--------------              ---------      ------------ ------------
Ethernet 2                  192.168.56.115           24       Manual
Ethernet                    10.0.2.15                24       Manual
Loopback Pseudo-Interface 1 127.0.0.1                 8    WellKnown

PS C:\Users\Administrador> Get-NetIPInterface -AddressFamily IPv4 | Format-Table InterfaceAlias,Dhcp
InterfaceAlias                  Dhcp
--------------                  ----
Ethernet 2                  Disabled
Ethernet                    Disabled
Loopback Pseudo-Interface 1 Disabled

PS C:\Users\Administrador> Get-DnsClientServerAddress -AddressFamily IPv4 | Format-Table InterfaceAlias,ServerAddresses
InterfaceAlias              ServerAddresses
--------------              ---------------
Ethernet                    {192.168.56.115}
Ethernet 2                  {192.168.56.115}
Loopback Pseudo-Interface 1 {}

PS C:\Users\Administrador> Get-TimeZone | Select-Object Id
Id
--
Romance Standard Time

PS C:\Users\Administrador> Get-Date -Format 'dd/MM/yyyy HH:mm:ss'
29/10/2026 15:14:06
```

> La zona horària és la de Madrid i l’hora també està bé.

### Part 2. Instal·lació del rol AD DS

Localitzeu i utilitzeu el procediment adequat per instal·lar el rol AD DS i promocionar el servidor a controlador de domini. Documenteu breument les comandes o passos utilitzats.

> He instal·lat AD DS, DNS i les eines per administrar el domini.

```powershell
PS C:\Users\Administrador> Install-WindowsFeature AD-Domain-Services,DNS -IncludeManagementTools
Success Restart Needed Exit Code
------- -------------- ---------
True    No             Success

PS C:\Users\Administrador> Get-WindowsFeature AD-Domain-Services,DNS,RSAT-AD-Tools | Select-Object Name,InstallState
Name               InstallState
----               ------------
AD-Domain-Services    Installed
DNS                   Installed
RSAT-AD-Tools         Installed
```

> He deixat el DNS escoltant només a la 192 per no donar la IP de la NAT als clients.

```powershell
PS C:\Users\Administrador> dnscmd.exe localhost /ResetListenAddresses 192.168.56.115
Direcciones de escucha restablecidas correctamente.
Comando completado correctamente.
```

### Part 3. Promoció a controlador de domini
Promocioneu el servidor a controlador de domini amb les opcions següents:

| Opció                                  | Valor              |
| -------------------------------------- | ------------------ |
| Tipus d’implantació                    | Crear un nou bosc  |
| Nom del domini arrel                   | `musiccloud.local` |
| Servidor DNS                           | Sí                 |
| Catàleg global                         | Sí                 |
| Nom NetBIOS                            | `MUSICCLOUD`       |
| Controlador de domini de només lectura | No                 |
| Reinici final                          | Sí                 |
Definiu una contrasenya segura per al mode de restauració de serveis de directori.

> He creat el bosc i el domini musiccloud.local. La contrasenya DSRM l’he entrat sense deixar-la escrita al document.

```powershell
PS C:\Users\Administrador> $dsrm = Read-Host 'Contrasenya DSRM' -AsSecureString
PS C:\Users\Administrador> $parameters = @{
    DomainName = 'musiccloud.local'
    DomainNetbiosName = 'MUSICCLOUD'
    InstallDns = $true
    SafeModeAdministratorPassword = $dsrm
}
PS C:\Users\Administrador> Test-ADDSForestInstallation @parameters
Message        : Operación completada correctamente.
Context        : Test.VerifyDcPromoCore.DCPromo.General.3
RebootRequired : False
Status         : Success

PS C:\Users\Administrador> Install-ADDSForest @parameters -Force
Message                             Context           RebootRequired Status
-------                             -------           -------------- ------
Operación completada correctamente. DCPromo.General.3          False Success
```

> Ha sortit l’avís de delegació DNS, però no cal fer res perquè és un bosc nou. En acabar s’ha reiniciat el servidor. És un controlador amb escriptura i catàleg global.

Procediment: [Install-ADDSForest de Microsoft](https://learn.microsoft.com/en-us/powershell/module/addsdeployment/install-addsforest?view=windowsserver2022-ps).

### Part 4. Verificació

Després del reinici, comproveu:

1. Que el servidor s’anomena `SRV-AD-01`.
>ficarem la següent comanda per verificar que sanomena aixi:
```powershell
PS C:\Users\Administrador> hostname
SRV-AD-01
PS C:\Users\Administrador>
```
    
2. Que el domini `musiccloud.local` existeix.
>per comprovar que existeixi fem servir aquesta comanda:
```powershell
PS C:\Users\Administrador> Get-ADDomain | Select-Object DNSRoot

DNSRoot
-------
musiccloud.local


PS C:\Users\Administrador>
```
    
3. Que el servidor és controlador de domini.
    >per veure aixo farem servir aquesta comanda
```powershell
    PS C:\Users\Administrador> Get-ADDomainController -Identity SRV-AD-01 | Select-Object Name,Domain

Name      Domain
----      ------
SRV-AD-01 musiccloud.local


PS C:\Users\Administrador>
```
>aqui es veu que es controlador de domini.
4. Que el servei DNS està instal·lat.
```powershell

PS C:\Users\Administrador> Get-WindowsFeature DNS

Display Name                                            Name
------------                                            ----
[X] Servidor DNS                                        DNS


PS C:\Users\Administrador>

```
>aqui es veu que si que esta instalat. hem fet servir la comand agetwindowsfeature.
    
5. Que el DNS resol correctament el domini.
>Per veureu ficarem la següent comanda:
```powershell
PS C:\Users\Administrador> Resolve-DnsName musiccloud.local -Type A -Server 192.168.56.115

Name                                           Type   TTL   Section    IPAd
                                                                       dres
                                                                       s
----                                           ----   ---   -------    ----
musiccloud.local                               A      600   Answer     192.
                                                                       168.
                                                                       56.1
                                                                       15


PS C:\Users\Administrador>
```
>aqui es veu que resol perfectament el seu domini.
Completeu la taula següent. Adjunta la comanda que has utilitzat per a cada una de les comprovacions.

| Comprovació | Resultat | Comanda utilitzada |
| --- | --- | --- |
| Nom del servidor | SRV-AD-01 | `hostname` |
| IP fixa configurada | 192.168.56.115 /24, Manual | `Get-NetIPAddress -InterfaceAlias "Ethernet 2" -AddressFamily IPv4` |
| AD DS instal·lat | Installed | `Get-WindowsFeature AD-Domain-Services` |
| Domini creat | musiccloud.local | `Get-ADDomain \| Select-Object DNSRoot` |
| DNS instal·lat | Sí, surt marcat amb [X] | `Get-WindowsFeature DNS` |
| Resolució de musiccloud.local | Resol a 192.168.56.115 | `Resolve-DnsName musiccloud.local -Type A -Server 192.168.56.115` |
| Eines d’Active Directory disponibles | RSAT-AD-Tools instal·lat | `Get-WindowsFeature RSAT-AD-Tools` |

## Preguntes

Responeu breument:

1. Per què `SRV-AD-01` necessita una IP fixa?

> perquè els clients el trobin sempre a la mateixa IP i puguin accedir al domini i al DNS.

2. Per què és necessari DNS en un domini Active Directory?

> perquè els equips puguin trobar el controlador de domini i els serveis de l’AD.

3. Quina diferència hi ha entre instal·lar AD DS i promocionar el servidor a controlador de domini?

> instal·lar AD DS posa el rol al servidor. Promocionar-lo configura l’AD i converteix el servidor en controlador de domini.

4. Quin és el nom del domini creat?

> musiccloud.local

5. Quin és el nom NetBIOS del domini?

> MUSICCLOUD

6. Per què no és recomanable que els clients del domini utilitzin un DNS extern com a DNS principal?

> perquè el DNS extern no coneix el nostre domini intern i els clients podrien tenir problemes per trobar-lo i iniciar sessió. Han de fer servir el DNS de SRV-AD-01.

