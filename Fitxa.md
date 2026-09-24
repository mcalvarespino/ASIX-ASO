# Fitxa 1 — Anàlisi inicial de MusicCloud

**Nom i cognoms:** Marcos Calvar Espino       
**Data:** 17/09/26
**Equip / parella:** N/A

## Objectiu

MusicCloud necessita reorganitzar la seva infraestructura informàtica. Abans d'instal·lar o configurar cap servei, cal entendre:

- qui treballa a l'empresa;
    
- quines funcions té cada persona;
    
- quins recursos existeixen;
    
- qui necessita accedir a cada recurs;
    
- com podem gestionar aquests accessos de manera eficient.
    

---

# 1. Conèixer MusicCloud

Consulta la informació disponible sobre els departaments, treballadors i perfils d'usuari de MusicCloud.

Completa la taula següent.

| Persona | Departament | Funció / responsabilitat | Necessita privilegis especials? Per què? |
|---|---|---|---|
| Aina Ciurans | Direcció | Gestió general i presa de decisions de l'empresa. | Sí. Ha de accedir a els espais de Direcció i mirar alguns recursos del departament o departamentals.., però dinformàtica no necesita permissos. |
| Dídac Gassó | Administració | Factures, contractes i documentació interna. | No. Com a usuari normal o estandard, necessita els recursos comuns entre tots i els del seu departament en concret. |
| Laia Macias | Administració | Tasques administratives i coordinació del departament. | Sí. Com a responsable necessita acces complet a `gestio_departament` i tenri acces a informacio compartida amb Direcció per consultar-la. |
| Lluïsa Richart | Suport tècnic | Manteniment, incidències i coordinació de Suport tècnic. | Sí. Es la responsable del departament i necessita accedir a la carpeta de gestió i als scripts ja que es de manteniment també. |
| Meritxell Reglat | Producció musical | Gestió de continguts musicals i coordinació del departament. | Sí. És la responsable i necessita acces a `gestio_departament`, a més dels recursos que tenen els de producció. |
| Talia Costas | Informàtica | Administració dels sistemes i coordinació d'Informàtica. | Sí. Com a administradora del sistema necessita gestionar usuaris, grups, permisos, serveis, logs, configuracions i backups es a dir els recursos inormàtics per administrar el sistema o cordinarlo també.... |
| Alex Soriano | Informàtica | Suport i administració del sistema informàtic. | Sí. Necessita privilegis tecnics per mantenir els sistemes, segons les tasques que se liassignin... |
| Pere Espinalt | Externs | Col·laboració temporal en recursos concrets. | Necessita un accés especial pero limitat: nomes ha de poder accedir  als recursos publics o compartits que se li assignin, sense informació interna de la empresa ni administracio. |

### 1.1. Reflexió

Quines diferències observes entre un **treballador**, un **departament** i una **funció o responsabilitat**?

---
Un treballador es una persona concreta amb un compte d'usuari a la empresa.

---
Un departament es una unitat organitzativa per exemple al windows server que agrupa persones amb un ambit de feina que comparteixen tots
---
Una funcio o responsabilitat descriu que fa una persona i quins accesos ha de tenri o que pot requererir accesos diferents encara que comparteixi departament amb altres treballadors.

Hi ha persones que, pel seu càrrec o funció, necessiten accessos diferents dels altres membres del seu departament?

X Sí  
☐ No

Posa'n algun exemple:
Per exemple la Laia forma part d'Administració com Dídac, pero per exemple com que es la responsable ha de poder accedir a `gestio_departament`. O un altre sexemple seria la Talia, a part de formar part de Informàtica necessita permisos d'administració sobre backups, logs i configuracions.

# 2. Recursos de l'empresa

Analitza l'estructura d'informació de MusicCloud.

Classifica alguns dels recursos següents segons la seva finalitat.

| Recurs | Qui creus que l'hauria d'utilitzar? | Per a què? |
|---|---|---|
| `/empresa/comu/intercanvi` | Tot el personal i els externs autoritzats. | Per intercanviar temporalment documents, i mes esspecificament amb persones externes o altres treballadors... |
| `/empresa/comu/comunicats` | Direcció per publicar i la plantilla interna per consultar. | Per difondre comunicats interns de la empresa. Els externs no hi han de accedir clarament. |
| `/empresa/departaments/administracio/compartida` | Administració amb L/E i Direcció amb L. | Per compartir la documentacio de treball que es sol fer servir al departament. |
| `/empresa/departaments/administracio/gestio_departament` | Laia amb L/E i Direcció amb L. | Per gestionar i validar informació que esta reservada a la responsable d'Administració. |
| `/empresa/projectes/campanya_estiu` | nomes les persones assignades al projecte. | Per compartir els fitxers de Campanya Estiu entre els que participen (poden ser de diversos departaments). |
| `/empresa/administracio_sistema/backups` | Els administradors del sistema d'Informàtica. | Per crear, protegir, comprovar i restaurar còpies de seguretat com la carpeta diu. |

---

# 3. Qui ha de poder fer què?

| Situació | Accés proposat | Justificació |
|---|---|---|
| Dídac accedeix a la carpeta compartida d'Administració | **L/E** | Es membre d'Administració i hi treballa amb documents del departament de administració. |
| Laia accedeix a la gestió del departament d'Administració | **L/E** | Es la responsable d'Administració i ha de coordinar i validar documentació. |
| Pere, treballador extern, accedeix als comunicats interns | **NA** | Els comunicats són interns i el perfil extern no poden tenir acces per que no han de veure aquesta informació per clars motius. |
| Talia accedeix als backups del sistema | **ADM** | És administradora del sistema i ha de gestionar i restaurar les còpies a les hroes li donarem permissos de admin. |
| Un membre de Producció musical accedeix a la carpeta d'Administració | **NA** | No forma part d'Administració i no ha de poder accedir a aquests recursos per que no es la feina que li toca. |
| Un participant de `campanya_estiu` accedeix als fitxers del projecte | **L/E** | En estar assignat al projecte, ha de poder consultar i crear els fitxers a aquest directori logicament. |


# 4. Primer problema: com assignem els permisos?

Imagina que MusicCloud té només quatre treballadors:

- Anna
    
- Biel
    
- Carla
    
- David
    

Tots quatre treballen al mateix departament i necessiten accedir a la mateixa carpeta.

Una possible solució seria configurar:

```text
Anna  → lectura/escriptura
Biel  → lectura/escriptura
Carla → lectura/escriptura
David → lectura/escriptura
```

### 4.1.

Què passaria si l'empresa tingués **100 treballadors** amb el mateix tipus d'accés?

Caldria repetir 100 vegades la mateixa configuracio, Seria molt lent de fer a part de  difícil de revisar i augmentaria la possibilitat d'errors o de permisos diferents entre persones amb la mateixa necessitat per que som sers humans.

### 4.2.

Què passaria cada vegada que s'incorporés una persona nova?

S'haurien de fer manualment tots els seus accessos un per un a part de crearli un perfil pero no entra a aquesta pregunta a part també seria fàcil oblidar algun recurs necessari o donar-ne algun de més o de memys(cometre errors).

### 4.3.

Caldria retirar tots els permisos de l'antic departament un per un i afegir individualment els del nou.amb la posibilitat de oblidarse de algun a part, podria conservar accés a informació que ja no necessita sense volguer i ja estariem fent les coses malament.

### 4.4.

Proposa una manera de gestionar aquestes persones conjuntament.

Crearia conjunts de persones que tinguin les mateixes necessitats dacces o permissos i assignaria els permisos a cada conjunt. Quan una persona entres, sortis o canvies de funcio o departament, nomes caldria modificar a quin conjunt pertany aixo crec que e spot fer faicl amb windows server active directory.

# 5. Canvis a MusicCloud

Ara es produeixen aquests tres canvis:

### Cas A

Dídac deixa Administració i passa a Producció musical.

Quins accessos hauria de perdre?

Els permisos L/E sobre `/empresa/departaments/administracio/compartida` i `/empresa/departaments/administracio/documentacio_interna`, i qualsevol acces que sigui exclusiu de Administració. i no per lacces a `gestio_departament` per que no tenia accés a `gestio_departament` perquè no era el responsable.

Quins accessos hauria d'obtenir?

L/E sobre `/empresa/departaments/produccio_musical/compartida`, `artistes` i `cataleg`. No hauria d'accedir a `gestio_departament`, a no ser que fos el responsable en un futur. Els accessos comuns es mantenen i els de projectes només s'afegeixen si hi participa per exemple al destiu o a altres...

---

---

### Cas B

S'incorpora una nova treballadora al departament d'Administració.

Quins accessos caldria configurar?

Caldria crear el compte i la carpeta personal, donar-li els accessos comuns d'una treballadora interna i a les hores assignar L/E a `administracio/compartida` i `administracio/documentacio_interna`; mantenir `gestio_departament` en NA si no és la responsable tambe afegir només els projectes en què participi que pot variar...
---

---

---

### Cas C

Pere Espinalt deixa de col·laborar amb MusicCloud.

Què hauríem de fer amb els seus accessos?

Caldria desactivar al moment el compte, retirar-lo de tots els accessos temporals i projectes, a part les contraseñes i les sesiosn referents a la empresa que tingui iniciaceds i conservar o transferir els fitxers necessaris segons la política de l'empresa i la seva informaciò. I clarament no borrarem el compte per traçabilitat simplement el deshabilitarem

---

---

---

# 6. Busquem una solució millor

Suposa ara que podem crear conjunts de persones que comparteixen unes mateixes necessitats d'accés.

Per exemple:

```text
Administració
    ├── Dídac
    ├── Laia
    └── Roser
```

I podem donar permisos directament al conjunt:

```text
Administració → carpeta_administracio → L/E
```

### 6.1.

Quin avantatge té aquesta solució respecte a donar permisos persona per persona?

Els permisos es defineixen una sola vegada per a tot el conjunt de persones o usuaris i  això redueix la feina i els errors a part mante criteris sempre iguals i facilita els cambis de departament i aquestes coses

---

---

### 6.2.

Si Dídac passa d'Administració a Producció musical, què caldria modificar?

Caldria treure'l del conjunt Administració amb els permisos que te el conjunt i afegir-lo al conjunt Producció musical. Els permisos es ficaram automaticament sense haver d'editar cada un manualment

---

---

### 6.3.

Com anomenaries aquests conjunts de persones?

Grups de usuaris
---

---

# 7. Primera proposta per a MusicCloud

A partir de l'organització de l'empresa, proposa els primers conjunts de persones que crearies.

**No cal trobar encara la solució definitiva.**

| Nom proposat | Qui hi pertanyeria? | Per què existeix aquest conjunt? |
|---|---|---|
| Direcció | Aina Ciurans i Rut Tornil | Per gestionar els recursos  de Direcció i mirar la informació del departament. |
| Administració | Dídac Gassó i Laia Macias | Per accedir als recursos comuns d'Administració. La responsabilitat de Laia es tracta amb un grup a part. |
| Suport tècnic | Estel Birosta, Aina Zuriguel i Lluïsa Richart | Per gestionar les incidències i els recursos de Suport tecnic. |
| Producció musical | Roser Alberch, Guillem Adella, Meritxell Reglat, Alícia Monclús, Carles Molins i Eulàlia Galcera | Per gestionar artistes, els catalegs o els documents de producció. |
| Informàtica | Talia Costas i Alex Soriano | Per gestionar els recursos del departament i les tasques autoritzades dels de admin de sistema. |
---

# 8. Cas que complica el model

Laia treballa al departament d'Administració, però també és la responsable del departament.

És suficient que pertanyi només al conjunt `Administració`?

☐ Sí  
[x] No

Per què?


El conjunt Administració ha de donar els accessos comuns a Dídac i Laia, però Laia necessita privilegis que Dídac no ha de tenir, especialment sobre `gestio_departament`. ja que es la cap 
---

---

Quina possible solució proposes?

Mantindria Laia al grup Administració i l'afegiria a un segon grup, per exemple `Responsables_Administracio` o `Caps_de_departament`, amb els permisos que necesiti. Així una mateixa persona pot formar part de més d'un grup segons les seves funcions o necesitats

---

---

---

# 9. Un altre cas

Diverses persones de departaments diferents participen temporalment en el projecte:

```text
Campanya Estiu
```

Creus que hauríem de canviar-les de departament?

☐ Sí  
[x] No


Crearia un grup temporal `Campanya_Estiu`, hi afegiria les persones participants sense canviar-les de departament i assignaria al grup L/E sobre `/empresa/projectes/campanya_estiu`. Quan el projecte acabi, es treuran els membres o es desactivarien el grup i l'accés a ell.

---

---

---

# 10. Conclusions

Completa les frases amb les teves paraules.


### Usuari

Un usuari es una persona que te un compte al sistema
### Recurs

Es un element del sistema que es vol fer servir o protegir i podria ser cualsevol cosa com una carpet aper exemple 

### Permís

Son les accions que pot fer un usuari o grup sobre un recurs com ara be una carpeta, podria ser lleguir escrirue executar...

### Grup

Un grup serveix per reunir diversos usuaris amb necesitats semblants per assignarlis permissos de manera conjunta per exemple o per organització pero llavors seria una OU 
# 11. Regla de mínim privilegi

Analitza aquesta afirmació:

> Un usuari només hauria de tenir els permisos estrictament necessaris per realitzar la seva feina.

Explica amb les teves paraules què significa.

Vol dir que a un usuari no li has de donar permissos qu eno necesita exemple , si nomes ha de consultar les dades de una carpeta pero no ha de tocar res mes no li donguis escriptura , ja que podria fer algo que no es suposa que ha de fer ja sigui volguent o sense voler, a mes si per exemple li hackejessin el compte tendria mes permissos dels que deuria i podria liarla mes del que es suposa que pot fer...
---

---

Posa un exemple relacionat amb MusicCloud.

Pere, com a extern, pot tenir L/E a `/empresa/comu/intercanvi` per compartir documents temporals o ferne de nous,però ha de tenir NA als comunicats interns  als departaments i als backups ja que ell no ha de accedir ni verels de ninguna manera. Quan acabi la col·laboració, el seu accés s'ha de retirar de intercambi comu tambe clarament per que ja no es necesari no son permissos estrictament necesaris...
---

---

---

# 12. Pregunta final

Imagina que demà MusicCloud passa de 14 treballadors a 500.

Quina de les dues estratègies consideres més adequada?


☐ Assignar permisos individualment a cada usuari.

X Organitzar els usuaris segons les seves necessitats i assignar permisos a aquests conjunts.

Amb 500 treballadors els grups et deixen definir de una sola vegada els permisos de cada departament sense haver-ho de fer 1 per 1 del rol o projecte. Les altes  baixes i canvis es resolen modificant a quin grup pertanyen els usuaris. Això és més ràpid i segur que mantenir centenars d'assignacions individuals. Els permisos individuals només s'haurien d'utilitzar per a excepcions en concret.


---

---

---

Jo **no faria obligatori que acabessin tota la fitxa abans d'explicar res**. La utilitzaria de manera sincronitzada amb la classe:

**0–40 min:** apartats 1–3 → analitzen MusicCloud i els accessos.  
**40–65 min:** apartats 4–5 → apareix el problema de gestionar permisos individualment.  
**65–85 min:** explicació curta de **usuari, grup, recurs, permís i mínim privilegi**.  
**85–110 min:** apartats 6–9 → apliquen immediatament el concepte de grup.  
**110–120 min:** apartats 10–12 → revisió i tancament.

Hi ha una decisió pedagògica important: a l'apartat 4 **no utilitzo la paraula “grup” fins que l'alumnat ha intentat resoldre el problema**. Això encaixa molt millor amb el cicle que vols seguir: primer tenen el problema, després apareix la necessitat i només aleshores introdueixes el concepte teòric.
