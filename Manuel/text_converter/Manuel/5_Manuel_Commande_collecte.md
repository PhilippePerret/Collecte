## La commande `collecte` {#collectecommand}

La commande `collecte` permet de parser et surtout d'extraire tous les types de fichiers possible pour les analyses, même [le fichier statistiques].

Cette commande fonctionne, à la base, avec la spécification de l'opération a exécuter en premier argument :

~~~
  $  collecte [operation]
~~~

Il existe trois opérations principales :

~~~
  help      Pour obtenir l'aide du programme (ce manuel)
  parse     Pour parser les fichiers collecte
  extract   Pour extraire tout type de fichier des données
            de collecte.
~~~

En conséquence :

~~~
  $ collecte help pdf
  // => ouvre ce manuel en version PDF
  $ collecte help
  // => ouvre ce manuel en version HTML

  $ collecte parse
  // => parse tous les fichiers collecte du dossier dans lequel
  //    on se trouve

  $ collecte extract --all
  // => Extrait tous les fichiers possibles à partir des
  //    données  de collecte fournies, en format HTML
~~~

### Opération `collecte help` {#commande_collecte_help}

Comme nous venons de le voir, cette opération permet d'ouvrir le présent manuel, soit en version PDF (ajouter `pdf`) soit en version HTML (ne rien ajouter ou ajouter `html`).

### Opération `collecte parse` {#commande_collecte_parse}

Cette opération permet de parser tous les fichiers de collecte en vue de leur utilisation pour produire les fichiers d'analyse.

Le résultat de ce parsing est un fichier `film.pstore` ou `film.msh` qui contient toutes les données du film.

Les arguments possibles pour le parse sont :

~~~

  $ collecte parse
  // => Parse tous les fichiers existants dans le dossier
  //    courant.

  $ collecte parse mon/dossier/collecte
  // => Parse tous les fichiers du dossier `mon/dossier/collecte`

  $ collecte parse -p mon/dossier/collecte
  // => Parse seulement le fichier des personnages du
  //    dossier spécifié.

  $ collecte parse -b mon/dossier/collecte
  // => Parse seulement le fichier des brins du dossier
  //    spécifié.

~~~

Mais la collecte étant rapide, même pour un fichier de scènes, il vaut mieux tout collecter chaque fois.

### Opération `collecte extract` {#commande_collecte_extract}

C'est l'opération d'extraction des données qui permet de produire tous les fichiers nécessaires pour une analyse.

Cette opération connait le plus d'options, afin de pouvoir produire exactement ce qu'il faut.

#### Définir le temps de début et le temps de fin {#set_from_and_to_time}

Pour tous les fichiers extraits, on peut définir le temps de départ à l'aide des options `from` et `to` qui doivent définir une horloge `H:MM:SS`.

Exemple :

~~~
  $ collecte extract --all --from=0:12 --to=1:12:00
~~~

Avec la commande précédente, tous les fichiers seront extraits, entre la 12ème minute et 1 heure 12.

On peut utiliser aussi la formule d'option courte :

~~~
  $ collecte extract -a -f=0:12 -t=1:12:00
~~~

#### Produire des séquenciers
