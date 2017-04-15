# Collecte des informations {#collectefilm}

La *Collecte* est la première opération à exécuter. Elle consiste à rassembler toutes les informations du film dans un dossier appelé *dossier de collecte*.

Ce dossier contient tous les [fichiers de collecte].

## Les fichiers de collecte {#fichiersdecollecte}

On peut trouver dans la [dossier de collecte] les fichiers suivants :

* le fichier des personnages (-> le [fichier des personnages]),
* le fichier des brins (-> le [fichier des brins]),
* le fichier des scènes (-> le [fichier des scènes]),
* le fichier des métadonnées (-> le [fichier des métadonnées]).

## Dossier de collecte {#dossiercollecte}

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

## Définition de la fin du film {#definirfindufilm}

Pour définir la fin du film, il faut impérativement terminer le [fichier des scènes] par :

~~~

        H:MM:SS FIN

~~~

Dans le cas contraire, le programme prendra le temps de la dernière scène et lui attribuera arbitrairement une durée de 1 minute.

## Temps réels et temps relatifs {#tempsreelsetrelatifs}

Il faut comprendre que pour le programme il existe deux temps différents, les *temps réels* et les *temps relatifs*.

La divergence entre *temps réel* et *temps relatif* tient au fait que la première scène, dans la collecte, ne commence pas à l'horloge `0:00:00` mais après une amorce du film où sont présentés les producteurs et les diffuseurs.

Les *temps réels*, qui prennent pour référence une première scène qui commence vraiment à `0:00:00`, sont utilisés pour tous les temps des fichiers extraits de la collecte.

Pour [la commande `collecte`], ce sont toujours des *temps réels* qu'il faut fournir, pas des *temps relatifs*. Il convient de prendre ces temps dans les fichiers extraits, notamment les séquenciers complets.

## Collecte des scènes {#collectedesscenes}

Les scènes du film sont *collectées* dans un fichier du [dossier de collecte] :

~~~
      <dossier collecte>/scenes.collecte
~~~

Grâce au [bundle TextMate], ce fichier peut être créé à l'aide de la commande `Scènes : créer le fichier`.

### Format général d'une scène {#formatgeneralscene}

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

Chaque scène doit être **impérativement séparée de la précédente par une ligne vide** :

~~~
      0:00:06 INT. JOUR MAISON
      Première scène.

      0:00:42 EXT. NUIT JARDIN
      La scène suivante doit être séparée par une ligne.
~~~

La fin du film se détermine par la ligne :

~~~
      1:12:12 FIN
~~~

Cette ligne n'est pas comptée pour une scène.


### Appartenance de la scène à des brins ou des notes {#sceneinbrinsornotes}

Les dernières lignes de la scène peuvent permettre de l'introduire dans des brins ou des notes (principalement des brins).

Cette ligne comportera simplement les marques de ces appartenances, avec `b<id brin>` pour les brins ou `n<id note>` pour les notes.

Par exemple, cette scène appartiendra au brin 12 et à la note 4 :

~~~
      0:23:54 INT. JOUR MAISON DE JOE
      [PERSO#joe] rentre chez lui.
      b12 n4
~~~

### Points structurels de la scène {#pointsttinscene}

Les *points structurels*, ce sont les `pivots`, les `clé de voûte`, le début du dénouement et autres début de la seconde partie de développement.

On peut indiquer la présence de tels points structurels en mettant sur une ligne, plutôt à la fin, la *marque du point structurel* **et seulement cette marque**. Par exemple :

~~~
      0:23:54 INT. JOUR MAISON DE JOE
      [PERSO#joe] rentre chez lui.
      STT_CLE_DE_VOUTE
      b12 n4    
~~~

Si la scène contient plusieurs points structurels, ils doivent impérativement être spécifiés *sur des lignes différentes*. Par exemple :

~~~
      0:12:54 INT. JOUR MAISON DE JOE
      [PERSO#joe] rentre chez lui.
      STT_INC_PERT
      STT_INC_DEC
      b12 n4    
~~~


Avec le [bundle TextMate], il suffit de taper `stt` puis tabulation pour obtenir la liste des tous les points structurels possibles et choisir celui qu'on veut insérer dans la scène.

Cette liste contient :

~~~
      STT_INC_PERT      Incident perturbateur
      STT_INC_DEC       Incident déclencheur
      STT_PIVOT_1       Premier pivot
      STT_DEV_PART1     Première partie de développement
      STT_CLE_DE_VOUTE  Clé de voûte
      STT_DEV_PART2     Seconde partie de dveloppement
      STT_PIVOT_2       Second pivot
      STT_CRISE         Crise
      STT_DENOUEMENT    Début du dénouement
      STT_CLIMAX        Climax
~~~

Consulter le livre Narration sur la structure pour la définition de ces points.

### Création de la scène à l'aide du bundle TextMate

Avec le [bundle TextMate], il suffit d'utiliser le snippet `s` pour créer la scène (donc de taper « s » puis la touche tabulation).

En plus de ce snippet, le temps peut être entièrement géré par TextMate, ce qui permet de ne pas s'en soucier. Ouvrir le l'aide du bundle pour apprendre à le faire.


## Collecte et gestion des brins {#gestiondesbrins}

Un « brin » est comme une catégorie. Il permet de rassembler les scènes sous une même étiquette. Chaque sous-intrigue, dans une histoire, est un *brin*. Mais un *brin* peut aussi concerner un thème, un accessoire, une relation de personnage ou tout autre élément dramatique.

Les *brins* du film sont consignés dans le fichier :

~~~
      <dossier collecte>/brins.collecte
~~~

### Format général d'un brin

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

### Création du brin à l'aide du bundle TextMate

À l'aide du [bundle TextMate], on peut créer le fichier des brins grâce à la commande `Brins : créer le fichier`.

Ensuite, dans ce fichier, on peut utiliser le snippet `brin` pour créer un nouveau brin qui aura automatiquement le bon index (donc en tapant `brin` puis tabulation).

Pour de plus amples détails, voir l'aide du bundle (en tapant CMD+H **tandis qu'un fichier collecte est actif**).

## Collecte et gestion des personnages {#gestiondespersonnages}

Pour la collecte, les personnages du film sont consignés dans le fichier :

~~~
      <dossier collecte>/personnages.collecte
~~~

La définition des personnages permet d'utiliser des marques `[PERSO#<id personnage>]` dans les autres fichiers de collecte afin d'associer les *brins*, les scènes ou les beats de scène à des personnages. On gagne aussi énormément de temps en n'ayant pas à écrire le nom du personnage chaque fois.

Grâce à ces marques, par exemple, on peut déterminer le temps de présence d'un personnage à l'écran.

### Format général d'une donnée personnage {#formatgeneraldatapersonnage}

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

### Création du personnage à l'aide du bundle TextMate {#creationpersonnagewithbundle}

On peut créer le fichier `personnages.collecte`, avec le [bundle TextMate], en utilisant la commande `Persos : créer le fichier`.

Ensuite, dans ce fichier, il suffit d'utiliser le snippet `perso` pour créer facilement un nouveau personnage (donc de taper `perso` puis la touche tabulation).

Dans le [fichier de collecte des scènes][fichier des scènes], il suffit de taper `p` puis tabulation pour choisir un personnage très facilement.

Pour de plus amples détails sur l'utilisation des personnages, voir l'aide du bundle (en tapant CMD+H **tandis qu'un fichier collecte est actif**).

## Fichier des métadonnées {#fichiermetadata}

Un fichier de métadonnées peut être créé à la racine du dossier de collecte :

~~~
      <dossier collecte>/metadata.json
~~~

Ce fichier permet de définir les données suivantes :

~~~
      {
        /* Le titre du film */
        "titre": "<le titre du film>",
        /* ID du film */
        "id": "<identifiant filmodico",
        /* Les auteurs de la collect */
        "auteurs": ["Auteur 1", "Auteur 2"/* , etc. */],
        /* Date de debut de la collecte */
        "date_debut": "JJ/MM/AAAA",
        /* Date de fin de la collecte */
        "date_fin": "JJ/MM/AAAA"
      }
~~~

### Définition du titre du film {#definirtitrefilm}

Définir le titre, dans les métadonnées, à l'aide de la propriété `titre`.

### Définition de l'identifiant du film {#definiridentifiantfilm}

Définir l'identifiant Filmodico, dans les métadonnées, à l'aide de la propriété `id`.

### Dates de début et de fin de collecte {#definirdatedebutfincollecte}

Définir la date de début de collecte avec la propriété `date_debut` dans les métadonnées, et la date de fin de collecte, si la collecte est terminée, à l'aide de la propriété `date_fin`.

La valeur est une date sous la forme `JJ/MM/AAAA`. Par exemple `14/04/2017`.


### Définition des auteurs de la collecte {#definirauteurscollecte}

Définir le titre, dans les métadonnées, à l'aide de la propriété `auteurs`.


### Définition de la structure {#definitionstructure}

La structure du film peut être définie dans le [fichier des métadonnées], grâce à la donnée `structure` :

~~~

      // Dans le fichier metadata.json
      {
        ...
        "structure":{
          "pivot_1":              "0:21:45", // (*)
          "incident_perturbateur":"5:03",    // (*)
          "incident_declencheur": "12:20",   // (*)
          "developpement":        "0:25:00", // (*)
          "cle_de_voute":         "0:59:30", // (*)
          "crise":                "1:17:00", // (*)
          "pivot_2":              "1:24:12", // (*)
          "denouement":           "1:29:10", // (*)
          "climax":               "1:40:12"  // (*)
        }
      }
~~~

> (*) Il s'agit des temps réels (cf. l'[explication sur les temps réels et relatifs]). Ils peuvent être donc définis après une première extraction.

Ces temps permettent :

* de définir dans le fichier statistique les écarts par rapport au *Paradigme de Field Augmenté*.
* de séparer les actes dans le [fichier résumé] et le [fichier synopsis].
