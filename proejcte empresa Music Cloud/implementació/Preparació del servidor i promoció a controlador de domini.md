# Pràctica

> Estat de la pràctica: hem començat la preparació de la xarxa. La comprovació després del reinici ha quedat pendent perquè no hem pogut tornar a entrar al servidor abans d’aturar la sessió. Encara no hem instal·lat AD DS ni hem creat el domini.

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

| Paràmetre        | Valor configurat |
| ---------------- | ---------------- |
| Adreça IP        |                  |
| Màscara          |                  |
| Porta d’enllaç   |                  |
| DNS preferit     |                  |
| Nom del servidor |                  |

### Preparació que hem fet fins ara

> Primer hem mirat com estava el servidor. Es deia `WIN-FTMF63VOMCU`, estava a `WORKGROUP` i no tenia AD DS ni DNS instal·lats. Les dues targetes agafaven la IP per DHCP.

```powershell
PS C:\Users\Administrador> Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias,IPAddress,PrefixLength,PrefixOrigin
InterfaceAlias IPAddress       PrefixLength PrefixOrigin
-------------- ---------       ------------ ------------
Ethernet 2     192.168.56.115              24 Dhcp
Ethernet       10.0.2.15                  24 Dhcp
```

> La xarxa que farem servir per a l’AD és `192.168.56.115/24`, amb màscara `255.255.255.0`. La targeta de la xarxa 192 no necessita porta d’enllaç. La sortida a Internet va per la NAT, amb porta d’enllaç `10.0.2.1`.

> Hem reservat les adreces a VirtualBox per a les MAC d’aquest servidor, perquè el DHCP no les doni a un altre equip:

```powershell
VBoxManage dhcpserver modify --interface="VirtualBox Host-Only Ethernet Adapter" --mac-address=080027C41C1E --fixed-address=192.168.56.115
VBoxManage dhcpserver modify --network=NatNetwork --mac-address=080027DFE54D --fixed-address=10.0.2.15
```

> Després hem iniciat el canvi de les IP a manuals, el DNS propi i el nom `SRV-AD-01`. En treure DHCP, Windows ha retirat l’adreça antiga de la NAT i el primer intent s’ha aturat. Hem corregit el guió i l’hem tornat a iniciar. La connexió s’ha tallat durant el procés i encara no hem pogut confirmar el resultat final.

> Per tant, aquests són els valors previstos, però **encara falta comprovar que hagin quedat aplicats**. La taula de valors configurats i les verificacions finals queden pendents. També queda pendent instal·lar AD DS, crear el bosc i el domini, i fer les comprovacions de DNS.

> La zona horària inicial ja era `Romance Standard Time`, corresponent a Madrid.

### Part 2. Instal·lació del rol AD DS

Localitzeu i utilitzeu el procediment adequat per instal·lar el rol AD DS i promocionar el servidor a controlador de domini. Documenteu breument les comandes o passos utilitzats.

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
    

