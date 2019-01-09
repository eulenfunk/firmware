# Eulenfunk Firmware Repository - Stand 09.01.2019

Freifunk Firmware für Freifunk Düsseldorf-Flingern und Freifunk im Neanderland (Neanderfunk) 

## build-Prozess


Pre-Requsites:

gluon-dependencies müssen ebenfalls auf dem System installiert sein (Stand 09.01.2019(.

```sudo apt install git subversion python build-essential gawk unzip libncurses5-dev zlib1g-dev libssl-dev wget time```


Sites-Dateien, wie `sites.ffmet` enthalten eine Liste an Site-Konfigurationen die aus dem Template (aus `templates/`) erstellt werden.
Diese enthalten dann Zeilen im Format wie `experimentall2tp v2018.2.x dusl2tp dusl2tp`.
Achtung, Zeile mit muss mit `<CR>` abgeschlossen sein,  Leerzeilen sind ungültig.

### Serviervorschlag:


```
git clone https://github.com/eulenfunk/firmware
cd firmware
git clone https://github.com/freifunk-gluon/gluon
./build.sh sites.ffmet
```


Das Buildscript wird mit der Sites-Datei als Parameter aufgerufen, zusätzlich können beliebig viele Architekturen angegeben werden, für die Images gebaut werden sollen. Wird keine Architektur angegeben, werden alle gebaut.

`./build.sh sites.ffmet ar71xx-generic ar71xx-nand`



## Branches
broken, experimental und stable 

- **broken** exisitiert kein Release Kanal, **experimental** der Kanal `experimental` und **stable* ist Kanal `stable`
- **nur Freifunk Düsseldorf-Flingern**: es gibt jeden Releasekanal in "l2tp" und "fastd" (bei fastd entfällt der namenszusatz im Releasekanal)
- **nur Neanderfunk**: es gibt einen den Releasekanal (fastd).

- es gibt noch den zusätzlichen _Bau-Stand_ **key** (z.B. **stable/stablekey stablel2tp/stablel2tpkey**) in der "bypassconfigmode" und mehrere ssh-keys der Admins gesetzt sind. Diese Firmware wird auschließlich für Administratoren gebaut und ist ohne Rücksprache nicht zu verwenden!



## Development

You van check the right modules with

    tests/validate_site.sh

This will perform a basic check, if all packages from `site.mk` are found in any of the defined repositories in `modules`, gluon itself and the gluon/packages repo.
