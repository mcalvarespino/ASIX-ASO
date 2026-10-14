# Fitxa 2 — Organització del servei de directori de MusicCloud

**Informació de referència:** [Informació de MusicCloud](<Informació de MusicCloud.md>).

## Objectiu

En aquesta sessió hem decidit com organitzar els diferents objectes de MusicCloud dins d'un servei de directori.

Aquesta fitxa forma part de la **documentació de disseny del sistema**. Les decisions que hi indiquis s'utilitzaran posteriorment durant la implantació.

## 1. Objectes que hem de gestionar

MusicCloud necessita gestionar de manera centralitzada diferents tipus d'objectes.

Indica quins tipus d'objectes consideres que ha de contenir el servei de directori.

| Tipus d'objecte | Exemples a MusicCloud |
|---|---|
| Usuaris | Comptes dels treballadors d'Administració i Direcció; comptes de col·laboradors externs. |
| Grups | `GG_Administracio`, `GG_Direccio`, `GG_Campanya_Estiu`, `GP_Carpeta_Administracio_Lectura`. |
| Equips | Comptes dels ordinadors de sobretaula i portàtils de l'empresa. |
| Servidors | Servidor de fitxers, servidor d'aplicacions i servidors del directori. |
| Comptes de servei | Comptes dedicats a executar aplicacions o serveis, com les tasques de còpia de seguretat que els requereixin. |

Hi afegiries algun altre tipus d'objecte?

Sí, els comptes de servei utilitzats per aplicacions. També es poden incorporar altres recursos si la solució de directori els admet i hi ha una necessitat concreta. No s'ha de donar per fet que qualsevol NAS, impressora o dispositiu de xarxa s'integri al directori: els dispositius sense objecte propi es gestionaran mitjançant l'inventari o l'eina corresponent.

## 2. Organització mitjançant unitats organitzatives

Proposa les **unitats organitzatives (OU)** principals que utilitzaries a MusicCloud.

| OU | Què contindrà? | Per què la crees? |
|---|---|---|
| `Usuaris/Interns` | Comptes personals de la plantilla interna. | Per aplicar les polítiques habituals de treball als comptes interns. |
| `Usuaris/Externs` | Comptes personals dels col·laboradors externs. | Per aplicar restriccions d'ús i delegar la gestió d'aquests comptes temporals separadament dels interns. La caducitat es configura a cada compte. |
| `Grups` | Grups de departament, responsables, projectes, permisos i administració. | Per localitzar i gestionar els grups en un únic contenidor estable. |
| `Equips` | Comptes dels ordinadors clients. | Per aplicar les polítiques dels llocs de treball. |
| `Servidors` | Comptes dels servidors de directori, fitxers i aplicacions. | Per aplicar una configuració de servidor diferent de la dels equips clients. |
| `Comptes_de_servei` | Comptes utilitzats per aplicacions i serveis. | Per gestionar-ne els privilegis i restringir-ne l'ús interactiu segons les necessitats de cada servei. |

### 2.1. Organització dels usuaris

Dibuixa l'estructura que utilitzaries per organitzar els usuaris de MusicCloud.

```text
MusicCloud
└── Usuaris
    ├── Interns (tota la plantilla dels cinc departaments)
    └── Externs (Pere Espinalt i Neus Bages)
```

No es creen OU per departament perquè no s'han justificat polítiques o delegacions diferents per a cadascun. La pertinença a Administració, Direcció i la resta de departaments es representa amb grups.

## 3. OU o grup?

Indica quina opció utilitzaries principalment en cada cas.

| Necessitat | OU | Grup |
|---|:---:|:---:|
| Organitzar els treballadors d'Administració | ☐ | ☑ |
| Donar accés a la carpeta d'Administració | ☐ | ☑ |
| Organitzar els ordinadors clients | ☑ | ☐ |
| Identificar les persones que participen en Campanya Estiu | ☐ | ☑ |
| Organitzar els servidors | ☑ | ☐ |
| Donar privilegis als administradors del sistema | ☐ | ☑ |
| Organitzar els comptes utilitzats per aplicacions | ☑ | ☐ |

**Explica amb les teves paraules la diferència principal entre una OU i un grup.**

**OU:**
És un contenidor de la jerarquia del directori. Permet organitzar objectes, delegar-ne l'administració i aplicar polítiques als usuaris o equips que hi pertoquin. La ubicació en una OU no concedeix per si mateixa permisos sobre les carpetes compartides.

**Grup:**
Reuneix comptes o altres objectes que comparteixen una funció o una necessitat d'accés. Permet assignar permisos conjuntament. Un compte pot ser membre de diversos grups alhora, independentment de la seva ubicació dins de les OU.

## 4. Un mateix usuari: ubicació i pertinença

Considera aquest cas:

**Dídac Gassó**

- treballa a Administració;
- participa en el projecte Campanya Estiu.

**En quina OU ubicaries el seu compte?**

A `MusicCloud/Usuaris/Interns`, perquè és un treballador intern. El departament s'identifica mitjançant el grup corresponent.

**A quins grups pertanyeria?**

A `GG_Administracio` i `GG_Campanya_Estiu`, perquè treballa a Administració i participa en aquest projecte.

**Per què no és contradictori?**

L'OU indica la ubicació del compte dins la jerarquia del directori. Els grups expressen les seves funcions o pertinences. Un compte té una única ubicació dins l'arbre d'OU i pot pertànyer a diversos grups alhora; participar en un projecte no obliga a moure'l d'OU.

## 5. Servei de directori
Un **servei de directori** és un sistema que guarda i organitza informació sobre les persones i recursos d'una xarxa, i permet consultar-los i administrar-los de manera centralitzada des del mateix server.

A MusicCloud resol el problema de gestionar per separat els usuaris i els accessos de cada ordinador o aplicació a la empresa, aixo vol dir que facilita l'inici de sessió, l'administració dels equips i l'assignació ven feta de permisos i automatització

## 6. LDAP

Completa les frases següents.

**LDAP és:** un protocol que permet consultar i modificar informació d'un servei de directori.

**LDAP no és:** un servei de directori ni un producte concret, i tampoc és sinònim d'Active Directory. És el protocol que utilitzen els clients per accedir a la informació d'un servei de directori i fer-hi operacions, com consultes o modificacions. Active Directory i OpenLDAP són exemples de solucions que utilitzen LDAP.

| Afirmació | C | F |
|---|:---:|:---:|
| LDAP és sinònim d'Active Directory | ☐ | ☑ |
| LDAP permet accedir i consultar informació d'un directori | ☑ | ☐ |
| OpenLDAP és una implementació d'un servei de directori | ☑ | ☐ |
| Active Directory utilitza LDAP, entre altres tecnologies | ☑ | ☐ |

## 7. DIT de MusicCloud
L'arbre següent mostra les OU proposades. Els comptes i grups concrets s'ubicaran dins del contenidor corresponent.

```text
MusicCloud
├── Usuaris
│   ├── Interns
│   └── Externs
├── Grups
├── Equips
├── Servidors
└── Comptes_de_servei
```

Tots els grups es desen directament a `Grups`: no hi ha OU de projectes, responsables o permisos. `GG_Campanya_Estiu` és un grup temporal; crear-lo o retirar-lo no modifica l'estructura estable d'OU. Els noms dels grups indiquen la seva finalitat.

Tampoc es creen subdivisions per departament, tipus de servidor o tipus d'ordinador sense justificar polítiques o delegacions diferents. Els dispositius sense objecte al directori es controlen a l'inventari; una OU `Xarxa` només es plantejaria si hi hagués dispositius compatibles i una necessitat concreta de gestió.

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
| `/empresa/comu/interdepartamental` | `GG_Direccio`: L/E; grup específic de col·laboració amb les persones autoritzades d'Administració o altres departaments, amb els accessos definits per la tasca (SP). |
| `/empresa/departaments/administracio/compartida` | `GG_Administracio`: L/E; `GG_Direccio`: L. |
| `/empresa/departaments/administracio/gestio_departament` | `GP_Administracio_Gestio_LE`: L/E; Direcció: L. |
| `/empresa/projectes/campanya_estiu` | `GG_Campanya_Estiu`: només els participants assignats. |
| `/empresa/projectes/nou_cataleg` i `migracio_servidors` | Grups de projecte respectius: només els participants assignats. |
| `/empresa/administracio_sistema/backups` | Grup específic d'administradors autoritzats: ADM. |

## 8. Justificació del disseny

Escull **dues decisions** del teu DIT que consideris importants i justifica-les.

### Decisió 1

Separar els comptes personals en `Usuaris/Interns` i `Usuaris/Externs`.

**Justificació:** els col·laboradors externs necessiten restriccions d'ús i una gestió diferenciada dels comptes interns. Aquesta distinció és estable. Els departaments es representen amb grups perquè no s'han justificat polítiques diferents per departament.

### Decisió 2

Desar tots els grups a `Grups`, sense crear OU per a projectes o responsables.

**Justificació:** la participació en projectes i les responsabilitats canvien més sovint que l'estructura del directori. Es modifica la pertinença als grups sense moure comptes ni crear OU noves. Una subdivisió només es crearia si una delegació administrativa concreta la fes necessària.

## 9. Comprovació final

Respon breument.

### a) Per què no seria una bona idea guardar tots els objectes al mateix nivell?

Perquè barrejar comptes personals, equips, servidors i comptes de servei en dificultaria la gestió i la delegació administrativa. Separar els tipus d'objecte permet aplicar les polítiques adequades als usuaris i equips, sense afegir subdivisions innecessàries.

### b) Per què no hauríem d'utilitzar les OU per substituir els grups de permisos?

Perquè una OU classifica i ajuda a administrar objectes dins de la jerarquia que voem montar, mentre que els permisos es poden concedir a grups. Una persona pot necessitar accessos de diversos projectes sense canviar de departament ni d'OU, sinplement ficantlo o treientlo de un grup amb permissos 

### c) Si MusicCloud passa de 14 a 500 treballadors, què facilitarà més l'administració?

La separació estable per tipus d'objecte i per necessitats de gestió, combinada amb grups per departaments, funcions i projectes. Permet incorporar persones o canviar-ne les tasques modificant els grups, sense redissenyar les OU ni concedir permisos persona per persona.

## Documentació final del sistema

A partir de les decisions preses durant la sessió, deixa definida la proposta que utilitzarem inicialment per a MusicCloud.

### Estructura d'unitats organitzatives

```text
MusicCloud
├── Usuaris
│   ├── Interns
│   └── Externs
├── Grups
├── Equips
├── Servidors
└── Comptes_de_servei
```

### Criteri utilitzat per organitzar els objectes

Primer es classifiquen segons el tipus d'objecte. Els comptes personals se separen en interns i externs per les seves necessitats de gestió i polítiques. Els departaments, les responsabilitats i els projectes es representen amb grups dins de `Grups`. Les subdivisions noves només es crearan si cal aplicar polítiques diferents o delegar-ne l'administració.

### Criteri utilitzat per diferenciar OU i grups

Les **OU** defineixen la ubicació dels objectes dins la jerarquia del directori i permeten organitzar-los, delegar-ne la gestió i aplicar polítiques als usuaris o equips. Els **grups** representen departaments, funcions o projectes i permeten assignar els accessos corresponents. Un compte té una única ubicació dins l'arbre d'OU i pot pertànyer a diversos grups alhora.

### Comptes de servei

Els comptes utilitzats per executar aplicacions o serveis es desen a `MusicCloud/Comptes_de_servei`. No són comptes personals dels treballadors. Per a cada compte es documentaran el servei que l'utilitza, el responsable, els equips autoritzats i els recursos estrictament necessaris.

Per exemple, si l'eina de còpies necessita un compte dedicat, es crearà amb els permisos necessaris per executar i verificar les còpies. No se li donarà accés general a totes les carpetes ni privilegis d'administrador del domini per defecte. Se'n restringirà l'inici de sessió interactiu quan el servei no el necessiti i se'n gestionaran les credencials i el cicle de vida.
