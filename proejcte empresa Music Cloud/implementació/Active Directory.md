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
    
5.   Per què els departaments no s’han creat com a dominis diferents?
    

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
    

Justifiqueu breument l’ordre escollit.
