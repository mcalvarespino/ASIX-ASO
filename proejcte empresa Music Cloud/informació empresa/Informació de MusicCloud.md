# Informació de MusicCloud

Document de referència per a les activitats **Anàlisi inicial de MusicCloud** i **Organització del servei de directori de MusicCloud**. Recull la informació de l'enunciat facilitada pel professor. Les observacions finals identifiquen les discrepàncies entre les seves taules i l'arbre inicial.

## 1. Dades bàsiques de l'empresa

- **Nom:** MusicCloud.
- **Activitat principal:** plataforma digital de gestió, distribució i reproducció de música en línia.
- **Descripció:** els usuaris poden escoltar cançons, crear llistes de reproducció i consultar contingut musical. L'empresa gestiona artistes, àlbums, cançons, reproduccions i dades relacionades amb l'ús de la plataforma.
- **Nombre de treballadors indicat a l'enunciat:** 14, sense comptar els externs. La relació nominal de l'apartat 3 conté 15 persones internes; aquesta discrepància queda pendent de confirmació.

## 2. Departaments

| Departament | Funció |
|---|---|
| Direcció | Gestió general de l'empresa. |
| Administració | Factures, contractes i documentació interna. |
| Suport tècnic | Manteniment de sistemes i incidències. |
| Producció musical | Gestió de continguts musicals. |
| Informàtica | Suport del sistema informàtic. |
| Externs | Usuaris temporals o externs; no és un departament intern. |

## 3. Treballadors i caps de departament

Cada treballador està assignat a un departament. Cada departament, excepte Direcció, té un treballador que exerceix les funcions de cap.

| Treballadors | Departament | Cap de departament |
|---|---|---|
| Aina Ciurans i Rut Tornil | Direcció | No se n'assigna cap a l'enunciat. |
| Dídac Gassó i Laia Macias | Administració | Laia Macias |
| Estel Birosta, Aina Zuriguel i Lluïsa Richart | Suport tècnic | Lluïsa Richart |
| Roser Alberch, Guillem Adella, Meritxell Reglat, Alícia Monclús, Carles Molins i Eulàlia Galcera | Producció musical | Meritxell Reglat |
| Talia Costas i Alex Soriano | Informàtica | Talia Costas |

**Col·laboradors externs:** Pere Espinalt i Neus Bages. No es comptabilitzen dins de la plantilla interna.

## 4. Perfils d'usuari

| Perfil | Descripció | Necessitats principals |
|---|---|---|
| Usuari estàndard | Treballador habitual d'un departament. | Accedir a la carpeta personal, els recursos del seu departament i els recursos comuns de l'empresa. |
| Responsable de departament | Coordina el departament, consulta informació del seu equip i valida documents interns. | Accedir als recursos del departament amb permisos complets segons la matriu i consultar determinats informes o carpetes compartides amb Direcció. |
| Administrador del sistema | Manté els sistemes informàtics de l'empresa. | Crear i modificar usuaris, gestionar grups, configurar serveis, revisar logs, administrar permisos i accedir remotament als servidors. |
| Usuari extern | Col·laborador temporal amb accés limitat. | Accedir només als recursos públics o compartits específics autoritzats, sense administració ni accés general a informació interna. |

## 5. Estructura de carpetes

Les carpetes compartides separen els espais comuns, els departaments, les carpetes personals, els projectes transversals i l'administració del sistema.

### Arbre inicial de l'enunciat

```text
/empresa
├── comu
│   ├── intercanvi
│   ├── plantilles
│   ├── comunicats
│   └── interdepartamental
├── departaments
│   ├── direccio
│   │   ├── compartida
│   │   └── confidencial
│   ├── administracio
│   │   ├── compartida
│   │   ├── gestio_departament
│   │   └── documentacio_interna
│   ├── suport_tecnic
│   │   ├── compartida
│   │   ├── gestio_departament
│   │   ├── incidencies
│   │   └── scripts
│   └── produccio_musical
│       ├── compartida
│       ├── gestio_departament
│       ├── artistes
│       └── cataleg
├── usuaris
│   ├── usuari1
│   ├── usuari2
│   ├── usuari3
│   └── ...
├── projectes
│   ├── campanya_estiu
│   └── migracio_servidors
└── administracio_sistema
    ├── backups
    ├── logs
    ├── configuracions
    └── inventari
```

Les carpetes departamentals segueixen el patró `compartida`, `gestio_departament` i carpetes específiques. `gestio_departament` és per al responsable, amb la consulta de Direcció que especifica la matriu. A Administració, `compartida` i `documentacio_interna` són per a tots els membres; `gestio_departament` queda reservada a Laia Macias, amb lectura per a Direcció.

## 6. Matriu d'accessos de l'enunciat

| Recurs | Direcció | Administració | Suport tècnic | Producció musical | Informàtica | Externs |
|---|---|---|---|---|---|---|
| `/empresa/comu/intercanvi` | L/E | L/E | L/E | L/E | L/E | L/E |
| `/empresa/comu/plantilles` | L/E | L/E | L | L | L | NA |
| `/empresa/comu/comunicats` | L/E | L | L | L | L | NA |
| `/empresa/comu/interdepartamental` | L/E | SP | SP | SP | SP | NA |
| `/empresa/departaments/direccio/compartida` | L/E | NA | NA | NA | NA | NA |
| `/empresa/departaments/direccio/gestio_departament` | L/E | NA | NA | NA | NA | NA |
| `/empresa/departaments/direccio/confidencial` | L/E | NA | NA | NA | NA | NA |
| `/empresa/departaments/administracio/compartida` | L | L/E | NA | NA | NA | NA |
| `/empresa/departaments/administracio/gestio_departament` | L | R: L/E | NA | NA | NA | NA |
| `/empresa/departaments/administracio/documentacio_interna` | L | L/E | NA | NA | NA | NA |
| `/empresa/departaments/suport_tecnic/compartida` | L | NA | L/E | NA | NA | NA |
| `/empresa/departaments/suport_tecnic/gestio_departament` | L | NA | R: L/E | NA | NA | NA |
| `/empresa/departaments/suport_tecnic/incidencies` | L | NA | L/E | NA | NA | NA |
| `/empresa/departaments/suport_tecnic/scripts` | NA | NA | R: L/E | NA | NA | NA |
| `/empresa/departaments/produccio_musical/compartida` | L | NA | NA | L/E | NA | NA |
| `/empresa/departaments/produccio_musical/gestio_departament` | L | NA | NA | R: L/E | NA | NA |
| `/empresa/departaments/produccio_musical/artistes` | L | NA | NA | L/E | NA | NA |
| `/empresa/departaments/produccio_musical/cataleg` | L | NA | ATP | L/E | NA | NA |
| `/empresa/departaments/informatica/compartida` | L | NA | NA | NA | L/E | NA |
| `/empresa/departaments/informatica/gestio_departament` | L | NA | NA | NA | R: L/E | NA |
| `/empresa/usuaris/usuariX` | NA | NA | ATP | NA | ADM tècnica | NA |
| `/empresa/projectes/campanya_estiu` | NA | SP | SP | SP | NA | NA |
| `/empresa/projectes/nou_cataleg` | NA | NA | SP | SP | NA | NA |
| `/empresa/projectes/migracio_servidors` | NA | NA | SP | NA | NA | NA |
| `/empresa/administracio_sistema/backups` | NA | NA | NA | NA | ADM | NA |
| `/empresa/administracio_sistema/logs` | NA | NA | ATP | NA | ADM | NA |
| `/empresa/administracio_sistema/configuracions` | NA | NA | ATP | NA | ADM | NA |
| `/empresa/administracio_sistema/inventari` | NA | NA | L | NA | L/E | NA |

`/empresa/comu/intercanvi` està destinat a l'intercanvi temporal de documents amb usuaris externs.

### Llegenda

| Valor | Significat |
|---|---|
| NA | Sense accés al recurs. |
| L | Pot consultar el contingut, però no modificar-lo. |
| L/E | Pot llegir, crear, modificar i eliminar contingut. |
| ADM | Pot gestionar el recurs, els permisos i el manteniment tècnic. |
| R: L/E | Només el responsable del departament té lectura i escriptura; la resta del departament no hi accedeix. |
| SP | Només hi accedeixen els usuaris assignats al projecte corresponent. |
| ATP | Accés temporal, justificat i registrat per resoldre una incidència. |

## 7. Criteris de lectura i discrepàncies de l'enunciat

- La xifra declarada és de 14 treballadors, però la relació nominal en suma 15 (2 + 2 + 3 + 6 + 2). Es conserven tots els noms i es deixa la xifra pendent de confirmació; no s'elimina cap persona per ajustar-la.
- La matriu inclou `direccio/gestio_departament`, les carpetes d'Informàtica i el projecte `nou_cataleg`, que no apareixen a l'arbre inicial. Es documenten perquè s'han de tenir en compte en el disseny d'accessos.
- SP determina qui hi participa; el nivell concret d'accés s'ha de definir segons les tasques del projecte. A les fitxes es proposa L/E per al treball compartit de Campanya Estiu.
- Per compartir informació entre Direcció i Administració s'utilitza l'espai interdepartamental amb les persones autoritzades. L'accés SP d'Administració no implica accés a totes les carpetes privades de Direcció.
- NA expressa absència d'autorització en aquesta matriu. No implica crear una denegació explícita que pugui anul·lar altres accessos autoritzats per una funció o projecte.
