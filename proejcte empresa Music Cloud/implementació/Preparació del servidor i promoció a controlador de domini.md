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
### Part 4. Verificació

Després del reinici, comproveu:

1. Que el servidor s’anomena `SRV-AD-01`.
    
2. Que el domini `musiccloud.local` existeix.
    
3. Que el servidor és controlador de domini.
    
4. Que el servei DNS està instal·lat.
    
5. Que el DNS resol correctament el domini.
    
    
Completeu la taula següent. Adjunta la comanda que has utilitzat per a cada una de les comprovacions.

| Comprovació                          | Resultat |
| ------------------------------------ | -------- |
| Nom del servidor                     |          |
| IP fixa configurada                  |          |
| AD DS instal·lat                     |          |
| Domini creat                         |          |
| DNS instal·lat                       |          |
| Resolució de `musiccloud.local`      |          |
| Eines d’Active Directory disponibles |          |

## Preguntes

Responeu breument:

1. Per què `SRV-AD-01` necessita una IP fixa?
    
2. Per què és necessari DNS en un domini Active Directory?
    
3. Quina diferència hi ha entre instal·lar AD DS i promocionar el servidor a controlador de domini?
    
4. Quin és el nom del domini creat?
    
5. Quin és el nom NetBIOS del domini?
    
6. Per què no és recomanable que els clients del domini utilitzin un DNS extern com a DNS principal?
    

