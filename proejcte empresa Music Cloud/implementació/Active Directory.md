# Activitat: del disseny a l’arquitectura d’AD DS

# Context

MusicCloud ja ha completat el disseny lògic del seu servei de directori.  

Abans d’instal·lar Active Directory Domain Services, cal comprovar que l’alumnat identifica correctament els components que s’hauran d’implantar.  

# Identificació dels components

A partir de l’arquitectura prevista, indiqueu:

1.   Quin serà el nom del bosc.  
    >Musiccloud.local
    
2.   Quin serà el nom del domini.  
    >musiccloud.local En aquest cas tenim un únic domini, que també és el domini arrel del bosc.
    
3.   Quin servidor actuarà com a controlador de domini.  
    >SRV-AD-01
4.   Quin servidor proporcionarà DNS.  
    >SRV-AD-01que també farà de servidor DNS del domini.
5.   Quin protocol s’utilitzarà principalment per a l’autenticació.  
    >Kerberos. És el protocol que s’utilitzarà segurament per veure la identitat dels usuaris quan iniciïn sessió al domini.
    
6.   Quin protocol permetrà consultar els objectes.  
      >es LDAP, que permet consultar els objectes del directori i els seus atributs, com els usuaris, els grups i els equips o altres coses...
7.   7. Quin servei de Windows emmagatzema i administra els objectes del domini?
    >Active Directory Domain Services, o AD DS. És el servei que guarda i administra els objectes del domini al controlador de domini.
    

# Anàlisi de l’arquitectura

Responeu breument:

1.   Per què el servidor `SRV-AD-01` necessita una adreça IP fixa?

     > Perquè els equips el puguin trobar sempre a la mateixa adreça. Si la IP canviés, els clients podrien tenir guardada l’antiga i no trobar el servidor. Com que també farà de DNS, necessitem que aquesta adreça sigui estable.

2.   Per què els clients del domini han d’utilitzar un servidor DNS capaç de resoldre la zona d’Active Directory?

     > Perquè han de trobar el domini musiccloud.local i els seus serveis, no només resoldre pàgines d’Internet. Si fiquem un DNS que no coneix aquesta zona, els clients poden tenir problemes per unir-se al domini o iniciar sessió.

3.   Què passaria si `SRV-AD-01` estigués apagat?

     > Si s’apaga l’únic controlador, els clients no poden consultar el seu DNS ni fer noves validacions contra el domini. Algunes sessions obertes o inicis amb credencials guardades d’abans poden continuar, però això no vol dir que tots els recursos del domini segueixin disponibles.

4.   Per què un únic controlador de domini és acceptable al laboratori però insuficient en una empresa real?

     > Al laboratori va bé perquè fem proves amb menys màquines i si s’atura podem esperar a tornar-lo a posar en marxa. En una empresa, una avaria o un manteniment podria deixar els treballadors sense els serveis del domini. Per això cal tenir més d’un controlador i no dependre d’un sol servidor.

5.   Per què els departaments no s’han creat com a dominis diferents?

     > Perquè els departaments són de la mateixa empresa i ens interessa gestionar els comptes i els equips dins del mateix domini. En el nostre disseny ja identifiquem els departaments amb grups i fem servir les OU per organitzar els objectes. Crear un domini per departament complicaria la gestió sense una necessitat que ho justifiqui.

# Planificació de la implantació

Ordeneu les accions següents:

- crear els usuaris.  
    
- comprovar el DNS.  
    
- assignar els usuaris als grups.  
    
- instal·lar AD DS.  
    
- crear les unitats organitzatives.  
    
- preparar la xarxa del servidor.  
    
- unir el client al domini.  
    
- crear el bosc i el domini.  
    
- crear els grups.  
    
- comprovar el funcionament del domini.  
    

> Jo ho faria en aquest ordre:
>
> 1. Preparar la xarxa del servidor.
> 2. Instal·lar AD DS.
> 3. Crear el bosc i el domini.
> 4. Comprovar el DNS.
> 5. Crear les unitats organitzatives.
> 6. Crear els grups.
> 7. Crear els usuaris.
> 8. Assignar els usuaris als grups.
> 9. Unir el client al domini.
> 10. Comprovar el funcionament del domini.

Justifiqueu breument l’ordre escollit.

> Primer preparem la xarxa, el nom, la IP fixa i l’hora del servidor. Després instal·lem el rol AD DS i ja podem promocionar el servidor per crear el bosc i el domini.
>
> Un cop creat el domini comprovem el DNS perquè els clients el puguin trobar. Després creem les OU per tenir l’organització preparada i hi anem afegint els grups i els usuaris. Per assignar un usuari a un grup han d’existir tots dos.
>
> Al final unim el client i comprovem que podem iniciar sessió i que els serveis del domini funcionen. Així anem comprovant cada part abans de donar la implantació per acabada.
