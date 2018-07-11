# welche branches auf http://images.ffdus.de/ sind wichtig?
broken, experimental und stable (das was anderswo "experimental" heisst ist hier "broken". Das was anderswo "beta" heisst ist hier "experimental". Einfach damit normale User die stable nutzen und nichts anderes)

- broken ist der updatekanal `experimental`, experimental der kanal `experimental` und stable ist kanal `stable`
- es gibt jeden releasekanal in "l2tp" und "fastd" (bei fastd entfällt der namenszusatz im Releasekanal)
- es gibt zusätzlich noch einen "Bau-Stand" "key" (z.B. stable/stablekey stablel2tp/stablel2tpkey) in der "bypassconfigmode" und mehrere ssh-keys gesetzt sind. Das ist kein eigener releasekanal, sondern nur einer der im Kaanl des eigentlichen "normalen ohne key" bleibt. Ist nur für sysupgrades/factorytftp. sysupgrade-images werden aber gebracht, "wenn man aus anderen communities via shell kommt".

# welche images werden gebaut?
alle 12 ebenfalls ( 2 vpntypes x 3 releasenames (nur 2 channel) x 2 keytypes) 

# "others"
sind nur Hilfeleistungen für andere communities derzeit (kann aber wieder kommen)
