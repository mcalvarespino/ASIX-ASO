# Fitxa 2 — Organització del servei de directori de MusicCloud

## Objectiu

En aquesta sessió hem decidit com organitzar els diferents objectes de MusicCloud dins d'un servei de directori.

Aquesta fitxa forma part de la **documentació de disseny del sistema**. Les decisions que hi indiquis s'utilitzaran posteriorment durant la implantació.
# 1. Objectes que hem de gestionar

MusicCloud necessita gestionar de manera centralitzada diferents tipus d'objectes.

Indica quins tipus d'objectes consideres que ha de contenir el servei de directori.

| Tipus d'objecte | Exemples a MusicCloud |
|---|---|
| Usuaris | Comptes dels treballadors d'Administració i Direcció; comptes de col·laboradors externs. |
| Grups | `GG_Administracio`, `GG_Direccio`, `GG_Campanya_Estiu`, `GP_Carpeta_Administracio_Lectura`. |
| Equips | Ordinadors de sobretaula i portàtils de l'empresa a part impresores sais etc.... |
| Servidors | Servidor de fitxers, servidor d'aplicacions i servidors del directori. |



Hi afegiries algun altre tipus d'objecte?
hi afegiria els dispositius de xarxa que es puguin fucar al directori, com ara alguns NAS per les copeis de seguretat o carpetes compartides, impressores o equips de xarxa auqe aquets es poden ficar 100%. També es poden inventariar mòbils, encaminadors, commutadors i tallafocs, però no tots haurien de ser un objecte al server crec jo 

---

---

# 2. Organització mitjançant unitats organitzatives

Proposa les **unitats organitzatives (OU)** principals que utilitzaries a MusicCloud.

| OU | Què contindrà? | Per què la crees? |
|---|---|---|
| `Usuaris` | Comptes personals, separats per departament o tipus de relació. | Per administrar els comptes i aplicar configuracions segons el col·lectiu. |
| `Grups` | Grups de departament, projecte, permisos i administració. | Per trobar-los i mantenir-los ordenats; els permisos s'assignaran als grups, no a l'OU. |
| `Equips` | Ordinadors clients de sobretaula i portàtils. | Per aplicar configuracions adequades a cada tipus d'equip. |
| `Xarxa` | Dispositius compatibles amb el directori, si n'hi ha. | Per mantenir-los identificats sense barrejar-los amb ordinadors i servidors. |

## 2.1. Organització dels usuaris

Dibuixa l'estructura que utilitzaries per organitzar els usuaris de MusicCloud.

```text
MusicCloud
└── Usuaris
    ├── Direccio (Aina Ciurans, Rut Tornil)
    ├── Administracio (Dídac Gassó, Laia Macias)
    ├── Suport_Tecnic (Estel Birosta, Aina Zuriguel, Lluïsa Richart)
    ├── Produccio_Musical (Roser Alberch, Guillem Adella, Meritxell Reglat,
    │                     Alícia Monclús, Carles Molins, Eulàlia Galcera)
    ├── Informatica (Talia Costas, Alex Soriano)
    └── Externs (Pere Espinalt, Neus Bages)
```
---

# 3. OU o grup?

Indica quina opció utilitzaries principalment en cada cas.

| Necessitat | OU | Grup |
|---|:---:|:---:|
| Organitzar els treballadors d'Administració | ☑ | ☐ |
| Donar accés a la carpeta d'Administració | ☐ | ☑ |
| Organitzar els ordinadors clients | ☑ | ☐ |
| Identificar les persones que participen en Campanya Estiu | ☐ | ☑ |
| Organitzar els servidors | ☑ | ☐ |
| Donar privilegis als administradors del sistema | ☐ | ☑ |
| Organitzar els comptes utilitzats per aplicacions | ☑ | ☐ |

### Explica amb les teves paraules la diferència principal entre una OU i un grup.

**OU:**
és un contenidor/caixa que ordena els objectes(usuaris o el que sigui) en una estructura que te una jeraquia. Ajuda a adminsitrar  i a aplicar polítiques a un conjunt d'objectes dit de un altre manera ajuda a donar certes necesitats o treure a varis objectes o usuaris per exemple a lhora.

---

---

**Grup:**
agrupa o reuneix objectes que comparteixen una funcio semblant o una necessitat de permisos iguals/semblants i es fa servir per assignar permisos o privilegis a aquet conjunt, i logicament una persona pot ser de mes de un grup no com les OU.

---

---

---

# 4. Un mateix usuari: ubicació i pertinença

Considera aquest cas:

**Dídac Gassó**

- treballa a Administració;
    
- participa en el projecte Campanya Estiu.
    

Indica:

**En quina OU ubicaries el seu compte?**
a `MusicCloud/Usuaris/Administracio`, perquè és el seu departament principal.

---


A `GG_Administracio` i al grup que dona lectura i escriptura a la carpeta compartida d'Administració que ara no sabem el nom. com participa a la campanya destiu també a `GG_Campanya_Estiu`. Laia Macias, com a cap del departament, tindria a més els permisos de `gestio_departament`; Dídac no els rebria només per ser d'Administració logicament.

**Per què no és contradictori?**
 L'OU indica on es troba el compte dins l'estructura del directori que volem fer. Pero els grups et diuen les seves funcions i els accessos que necessita cad ausuari. Un compte ocupa una ubicació dins aquesta estructura jerarquica de OU, pero pot ser membre de diversos grups alhora amb diversos permissos, en cas de dubte sempre saplica el mes restrictiu si un es lectura i escriptura i a lhora te nomes lectura tindra nome slectura .

# 5. Servei de directori
Un **servei de directori** és un sistema que guarda i organitza informació sobre les persones i recursos d'una xarxa, i permet consultar-los i administrar-los de manera centralitzada des del mateix server.

A MusicCloud resol el problema de gestionar per separat els usuaris i els accessos de cada ordinador o aplicació a la empresa, aixo vol dir que facilita l'inici de sessió, l'administració dels equips i l'assignació ven feta de permisos i automatització
# 6. LDAP

Completa les frases següents.

**LDAP és:** un protocol que permet consultar i modificar informació d'un servei de directori.

**LDAP no és:** el nom d'un producte concret ni un dir literalment d'Active Directory; tampoc és, per si sol, tota la infraestructura del directori, es el servei que serveix per controlar les funcions de ad que es fan servir com ar abe consultar i modificar informacio dels serveis de directori 

| Afirmació | C | F |
|---|:---:|:---:|
| LDAP és sinònim d'Active Directory | ☐ | ☑ |
| LDAP permet accedir i consultar informació d'un directori | ☑ | ☐ |
| OpenLDAP és una implementació d'un servei de directori | ☑ | ☐ |
| Active Directory utilitza LDAP, entre altres tecnologies | ☑ | ☐ |


---

# 7. DIT de MusicCloud
El arbre del directori amb ou i grups que proposo es el següent:
 Els noms representen OU despres els grups i comptes concrets se situarien dins de la branca corresponent.

```text
MusicCloud
├── Usuaris
│   ├── Direccio
│   ├── Administracio
│   ├── Suport_Tecnic
│   ├── Produccio_Musical
│   ├── Informatica
│   └── Externs
├── Grups
│   ├── Departaments
│   ├── Responsables
│   ├── Projectes
│   ├── Permisos
│   └── Administradors
├── Equips
│   ├── Sobretaula
│   └── Portatils
├── Servidors
│   ├── Directori
│   ├── Fitxers
│   └── Aplicacions
├── Comptes_de_servei
└── Xarxa
    └── Dispositius_integrats
```

Els mòbils i altres aparells sense objecte al directori es controlaran amb un inventari o amb l'eina de gestió corresponent. Només es crearan subdivisions addicionals quan hi hagi una necessitat real de gestió.

**Grups inicials i membres:**

| Grup | Membres o criteri | Ús |
|---|---|---|
| `GG_Direccio` | Aina Ciurans i Rut Tornil. | Identificar Direcció i donar-li els accessos previstos. |
| `GG_Administracio` | Dídac Gassó i Laia Macias. | Recursos ordinaris d'Administració. |
| `GG_Suport_Tecnic` | Estel Birosta, Aina Zuriguel i Lluïsa Richart. | Recursos de Suport tècnic. |
| `GG_Produccio_Musical` | Roser Alberch, Guillem Adella, Meritxell Reglat, Alícia Monclús, Carles Molins i Eulàlia Galcera. | Recursos de Producció musical. |
| `GG_Informatica` | Talia Costas i Alex Soriano. | Recursos d'Informàtica; no atorga privilegis d'administrador per si sol. |
| `GG_Externs` | Pere Espinalt i Neus Bages. | Accés limitat a l'espai d'intercanvi. |
| `GG_Caps_Departament` | Laia Macias, Lluïsa Richart, Meritxell Reglat i Talia Costas. | Identificar responsables; els permisos de cada carpeta de gestió es delimiten per departament. |
| `GG_Campanya_Estiu`, `GG_Nou_Cataleg`, `GG_Migracio_Servidors` | Només les persones assignades a cada projecte. | Accés a la carpeta del projecte corresponent; falta confirmar-ne els membres. |
| `GG_Admins_Sistema` | Només el personal d'Informàtica designat explícitament. | Privilegis d'administració del sistema. |

Per exemple, `GP_Administracio_Gestio_LE` en forma part la **Laia Macias** i donaria lectura i escriptura a `/empresa/departaments/administracio/gestio_departament`. Es crearien grups equivalents per a Lluïsa Richart, Meritxell Reglat i Talia Costas als seus departaments. El grup general de caps identifica el rol, però no concedeix accés a totes les carpetes de gestió. Per a la lectura de Direcció i els accessos temporals justificats de Suport tècnic, es farien grups de permisos específics i limitats.

| Recurs | Grup o criteri de permís |
|---|---|
| `/empresa/comu/intercanvi` | Grups interns i `GG_Externs`: L/E, per a l'intercanvi temporal. |
| `/empresa/departaments/administracio/compartida` | `GG_Administracio`: L/E; `GG_Direccio`: L. |
| `/empresa/departaments/administracio/gestio_departament` | `GP_Administracio_Gestio_LE`: L/E; Direcció: L. |
| `/empresa/projectes/campanya_estiu` | `GG_Campanya_Estiu`: només els participants assignats. |
| `/empresa/projectes/nou_cataleg` i `migracio_servidors` | Grups de projecte respectius: només els participants assignats. |
| `/empresa/administracio_sistema/backups` | Grup específic d'administradors autoritzats: ADM. |


---

# 8. Justificació del disseny

Escull **dues decisions** del teu DIT que consideris importants i justifica-les.

### Decisió 1

Separar `Usuaris` segons els cinc departaments reals i  el extern.

**Justificació:** et deixa localitzar els comptes i ficar criteris de admn. diferents als treballadors i als col·laboradors externs de manera centralitzada. Si MusicCloud creix, es podran afegir departaments sense canviar tota l'estructura

### Decisió 2

Situar `Grups/Projectes` separat de les OU dels departaments.

**Justificació:** una campanya pot reunir persones d'àrees diferents. El grup `GG_Campanya_Estiu` representa aquesta participació sense haver de moure els comptes de la seva OU principal, aixi que aixo es fa en grups i no amb OU temporal o algo raro 


# 9. Comprovació final

Respon breument.

### a) Per què no seria una bona idea guardar tots els objectes al mateix nivell?

Perquè costaria localitzar-los, gestionarlos i aplicar configuracions adequades a cada tipus d'objecte es a dir si tots estiguessin al mateix nivell tindrien lo mateix. El problema augmentaria a mesura que creixés l'empresa sobre tot

### b) Per què no hauríem d'utilitzar les OU per substituir els grups de permisos?

Perquè una OU classifica i ajuda a administrar objectes dins de la jerarquia que voem montar, mentre que els permisos es poden concedir a grups. Una persona pot necessitar accessos de diversos projectes sense canviar de departament ni d'OU, sinplement ficantlo o treientlo de un grup amb permissos 

### c) Si MusicCloud passa de 14 a 500 treballadors, què facilitarà més l'administració?

La separació estable per tipus d'objecte i per departament com ho hem decidit muntar , combinada amb grups per als accessos. Permet afegir usuaris i noves àrees sense haver de tornar a fer el directori ni concedir permisos persona per persona i anar molt lent o poderte equivocar.


# Documentació final del sistema

A partir de les decisions preses durant la sessió, deixa definida la proposta que utilitzarem inicialment per a MusicCloud.

## Estructura d'unitats organitzatives

```text
MusicCloud
├── Usuaris
│   ├── Direccio
│   ├── Administracio
│   ├── Suport_Tecnic
│   ├── Produccio_Musical
│   ├── Informatica
│   └── Externs
├── Grups
│   ├── Departaments
│   ├── Responsables
│   ├── Projectes
│   ├── Permisos
│   └── Administradors
├── Equips
│   ├── Sobretaula
│   └── Portatils
├── Servidors
│   ├── Directori
│   ├── Fitxers
│   └── Aplicacions
└── Xarxa
    └── Dispositius_integrats
```
### Criteri utilitzat per organitzar els objectes

Primer es classifiquen segons el tipus d'objecte. Els usuaris es divideixen pel departament principal o la condició d'extern que es els externs clarament, despres els equips, pel tipus, els servidors, per la funció. Les subdivisions noves es crearan quan tirem endevant el projecte si tenim mes necesitats.

### Criteri utilitzat per diferenciar OU i grups

Les **OU** defineixen la ubicació en lestrucgura dels objectes i permeten organitzar-los i aplicar-hi polítiques de gestió. Els **grups** diuen la funcions i permisos vol dir que per exemple, l'accés a una carpeta o la participació en una campanya. Un usuari pot estar en una sola OU de l'arbre(ubicacio en la jerarquia del server) i formar part de diversos grups a lhora per gestionar els seus permissos ne les areas que faci falta.