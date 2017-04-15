# Le programme `Collecte` {#leprogrammecollecte}

Le programme `Collecte` permet de collecter les informations d'un film afin de produire des séquenciers, des synopsis, de sortir des statistiques, etc., tout fichier pouvant être utile pour les analyses.

## Les trois modes d'utilisation de `Collecte` {#troismodesutilisation}

* le mode d'aide : `collecte help`,
* le mode de parsing. Pour *parser* les [fichiers de collecte]
* le mode d'extraction. Pour extraire les fichiers des données collectées, on parle d'*extraction*.

~~~

      $ collecte help[ pdf|html]

      $ collecte parse[ options][ chemin/vers/dossier/collecte]

      $ collecte extract [options][ chemin/vers/dossier/collecte]

~~~

Par exemple en ruby :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.parse
      coll.extract(:all)
~~~
