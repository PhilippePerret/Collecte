# Parsing de la collecte {#parsingcollecte}

Le *parsing* est l'opération qui consiste à transformer les données collectées dans l'étape précédente en données utilisables pour créer des fichiers d'analyse, des statistiques, etc.

Pour parser un dossier de collecte, le plus simple est d'utiliser dans le Terminal la commande :

~~~
      collecte parse mon/dossier/collecte
~~~

Ou de le faire par ruby :

~~~
      coll = Collecte.new('mon/dossier/collecte')
      coll.parse
~~~

Pour tout savoir sur [la commande collecte].
