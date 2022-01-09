# Eulenfunk Firmware Repository - Stand 09.01.2021

Freifunk Firmware für Freifunk Düsseldorf-Flingern und Freifunk im Neanderland (Neanderfunk) 

## build-Prozess


Pre-Requsites:

gluon-dependencies müssen ebenfalls auf dem System installiert sein (Stand 09.01.2019).

```sudo apt install git subversion python build-essential gawk unzip libncurses5-dev zlib1g-dev libssl-dev wget time```


Sites-Dateien, wie `sites.ffmet` enthalten eine Liste an Site-Konfigurationen die aus dem Template (aus `templates/`) erstellt werden.
Diese enthalten dann Zeilen im Format wie `experimentall2tp v2018.2.x dusl2tp dusl2tp`.
**Zeilenumbrüche müssen im UNIX- Format** sein. Jede Zeile mit muss mit **`<LR>`** abgeschlossen sein,  Leerzeilen sind ungültig.

### Serviervorschlag:


```
git clone https://github.com/eulenfunk/firmware
cd firmware
git clone https://github.com/freifunk-gluon/gluon -b v2021.1.x
./build.sh sites.ffmet
```


Das Buildscript wird mit der Sites-Datei als Parameter aufgerufen, zusätzlich können beliebig viele Architekturen angegeben werden, für die Images gebaut werden sollen. Wird keine Architektur angegeben, werden alle gebaut.

`./build.sh sites.ffmet ar71xx-generic ar71xx-nand`



## Branches
experimental und stable 

- **experimental** der Kanal `experimental` und **stable* ist Kanal `stable`

- es gibt noch den zusätzlichen _Bau-Stand_ **key** (z.B. **stable/stablekey**) in der "bypassconfigmode" und mehrere ssh-keys der Admins gesetzt sind. Diese Firmware wird auschließlich für Administratoren gebaut und ist ohne Rücksprache nicht zu verwenden!

## Signaturen
Der Buildbot unterschreibt die Firmware mit einem private-key, der öffentlich ist. Dieses ist nur eine Absicherung des Downoad-Transportweges, keine für Firmware-Integrität. 
Auf den Releasechannels "experimental" ist die Minimum-Valid-Signatures auf 2 gesetzt (d.h. mindestens eine "reale" Maintainer-Signature), für "stable" steht sie auf 3, d.h. 2 trusted Signaturen notwendig.

## Development

You can check the right modules with

    tests/validate_site.sh

This will perform a basic check, if all packages from `site.mk` are found in any of the defined repositories in `modules`, gluon itself and the gluon/packages repo.
