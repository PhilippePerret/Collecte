## Collecte des informations {#collectefilm}

La *Collecte* est la première opération à exécuter. Elle consiste à rassembler toutes les informations du film dans un dossier appelé *dossier de collecte*.

Ce dossier contient :

* le fichier des personnages (cf. [fichier des personnages]),
* le fichier des brins (cf. [fichier des brins]),
* le fichier des scènes (cf. [fichier des scènes]).

### Dossier de collecte {#dossiercollecte}

Le « dossier de collecte » peut se situer n'importe où sur votre ordinateur. C'est dans ce dossier que seront produit les fichiers de données (Marshal ou PStore) ainsi que le dossier d'extraction où seront placés tous les fichiers extraits.

Sa hiérarchie normale est :

~~~
      .../dossier_collecte/scenes.collecte
                          /personnages.collecte
                          /brins.collecte
                          /data/film.pstore
                          /extraction/...
                                     /...
                                     /...
~~~

### Définition de la fin du film {#definirfindufilm}

Pour définir la fin du film, il faut impérativement terminer le [fichier des scènes] par :

~~~

        H:MM:SS FIN

~~~

Dans le cas contraire, le programme prendra le temps de la dernière scène et lui attribuera arbitrairement une durée de 1 minute.

### Temps réels et temps relatifs {#tempsreelsetrelatifs}

Il faut comprendre que pour le programme il existe deux temps différents, les *temps réels* et les *temps relatifs*.

La divergence entre *temps réel* et *temps relatif* tient au fait que la première scène, dans la collecte, ne commence pas à l'horloge `0:00:00` mais après une amorce du film où sont présentés les producteurs et les diffuseurs.

Les *temps réels*, qui prennent pour référence une première scène qui commence vraiment à `0:00:00`, sont utilisés pour tous les temps des fichiers extraits de la collecte.

Pour [la commande `collecte`], ce sont toujours des *temps réels* qu'il faut fournir, pas des *temps relatifs*. Il convient de prendre ces temps dans les fichiers extraits, notamment les séquenciers complets.

### Collecte des scènes {#collectedesscenes}

Les scènes du film sont *collectées* dans un fichier du [dossier de collecte] :

~~~
      <dossier collecte>/scenes.collecte
~~~

Grâce au [bundle TextMate], ce fichier peut être créé à l'aide de la commande `Scènes : créer le fichier`.

#### Format général d'une scène

Dans le fichier `scenes.collecte`, une scène se présente sous la forme :

~~~
      H:MM:SS LIEU EFFET DÉCOR
      Résumé de la scène. brins et notes
      Premier paragraphe. brins et notes
      Deuxième paragraphe. brins et notes
      etc.
~~~

Par exemple :

~~~
      1:25:52 INT. JOUR MAISON DE JOE
      [PERSO#joe] rentre chez lui. b12 (25)
      Joe se gare devant chez lui.
      Joe sort de sa voiture et traverse le parking.
      Joe rentre chez lui.
~~~

Ou, pour une scène *en parallèle* dans deux décors différents :

~~~
      1:45:12 INT./EXT. JOUR/NUIT VAISSEAU / BASE TERRESTRE
      Le capitaine [PERSO#anatoli] lance un appel au secours
      à la base. b45 (2)
      (2) On joue ici sur le contraste jour/nuit.
~~~

#### Création de la scène à l'aide du bundle TextMate

Avec le [bundle TextMate], il suffit d'utiliser le snippet `s` pour créer la scène (donc de taper « s » puis la touche tabulation).

En plus de ce snippet, le temps peut être entièrement géré par TextMate, ce qui permet de ne pas s'en soucier. Ouvrir le l'aide du bundle pour apprendre à le faire.


### Collecte et gestion des brins {#gestiondesbrins}

Un « brin » est comme une catégorie. Il permet de rassembler les scènes sous une même étiquette. Chaque sous-intrigue, dans une histoire, est un *brin*. Mais un *brin* peut aussi concerner un thème, un accessoire, une relation de personnage ou tout autre élément dramatique.

Les *brins* du film sont consignés dans le fichier :

~~~
      <dossier collecte>/brins.collecte
~~~

#### Format général d'un brin

Chaque brin, dans le fichier `brins.collecte`, a la forme :

~~~
      INDICE DU BRIN
      TITRE DU BRIN
      DESCRIPTION DU BRIN
~~~

> Chaque brin doit être séparé de l'autre par une ligne vide.

Par exemple :

~~~
      12
      Relation entre Joe et son chien
      Ce brin contient toutes les scènes qui concernent la
      relation de Joe avec son chien.

      13
      Utilisation de la casserole
      Ce brin contient toutes les scènes qui concerne
      l'utilisation qui est faite de la casserole qui
      servira finalement au meurtre.
~~~

> Noter que chaque brin doit être séparé d'une ligne.

#### Création du brin à l'aide du bundle TextMate

À l'aide du [bundle TextMate], on peut créer le fichier des brins grâce à la commande `Brins : créer le fichier`.

Ensuite, dans ce fichier, on peut utiliser le snippet `brin` pour créer un nouveau brin qui aura automatiquement le bon index (donc en tapant `brin` puis tabulation).

Pour de plus amples détails, voir l'aide du bundle (en tapant CMD+H **tandis qu'un fichier collecte est actif**).

### Collecte et gestion des personnages {#gestiondespersonnages}

Pour la collecte, les personnages du film sont consignés dans le fichier :

~~~
      <dossier collecte>/personnages.collecte
~~~

La définition des personnages permet d'utiliser des marques `[PERSO#<id personnage>]` dans les autres fichiers de collecte afin d'associer les *brins*, les scènes ou les beats de scène à des personnages. On gagne aussi énormément de temps en n'ayant pas à écrire le nom du personnage chaque fois.

Grâce à ces marques, par exemple, on peut déterminer le temps de présence d'un personnage à l'écran.

#### Format général d'une donnée personnage {#formatgeneraldatapersonnage}

Chaque personnage, dans le fichier `personnages.collecte`, est consigné sous la forme :

~~~
      PERSONNAGE:<identifiant texte personnage>
        PRENOM:         <prenom du personnage>
        NOM:            <nom du personnage>
        PSEUDO:         <pseudo (si autre que "Prénom Nom")>
        SEXE:           Homme ou Femme
        ANNEE:          <année de naissance>
        FONCTION:       <fonction dans l'histoire>
        DESCRIPTION:    <description du personnage>
        PRENOM_ACTEUR:  <prénom de l'acteur>
        NOM_ACTEUR:     <nom acteur>
~~~

#### Création du personnage à l'aide du bundle TextMate {#creationpersonnagewithbundle}

On peut créer le fichier `personnages.collecte`, avec le [bundle TextMate], en utilisant la commande `Persos : créer le fichier`.

Ensuite, dans ce fichier, il suffit d'utiliser le snippet `perso` pour créer facilement un nouveau personnage (donc de taper `perso` puis la touche tabulation).

Dans le [fichier de collecte des scènes][fichier des scènes], il suffit de taper `p` puis tabulation pour choisir un personnage très facilement.

Pour de plus amples détails sur l'utilisation des personnages, voir l'aide du bundle (en tapant CMD+H **tandis qu'un fichier collecte est actif**).
