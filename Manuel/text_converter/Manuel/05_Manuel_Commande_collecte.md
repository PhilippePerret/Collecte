## La commande `collecte` {#collectecommand}

La commande `collecte` permet de *parser* et d'*extraire* tous les types de fichiers possible pour les analyses, même [le fichier statistiques].

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
      // => parse tous les fichiers collecte du dossier
      //    dans lequel on se trouve

      $ collecte extract --all
      // => Extrait tous les fichiers possibles à partir
      //    des données  de collecte fournies, en format
      //    HTML.
~~~

Ces trois commandes s'utilisent avec des options ou des arguments que nous allons détailler. Mais pour commencer, il faut installer cette commande manuellement.

### Installation de la commande `collecte` {#installationcommandecollecte}

* Charger l'application `Collecte.app` dans le dossier Applications si nécessaire,
* Créer un lien symbolique de la commande dans `/usr/local/bin` pour pouvoir l'utiliser en ligne de commande.

Pour créer le lien symbolique, utiliser dans l'application Terminal :

~~~
      $ sudo ln -s /Application/Collecte.app/Contents/MacOS/Collecte /usr/local/bin/collecte
~~~

> Note : `sudo` n'est pas nécessaire si vous êtes en root.

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
      // => Parse tous les fichiers du dossier
      //    `mon/dossier/collecte`

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

### Emplacement des fichiers produits

Les fichiers extraits de la collecte sont placés dans un dossier `extraction` dans le [dossier de la collecte].

Leur nom dépendra des différentes options choisies. Cf. [nom des fichiers extraits].
