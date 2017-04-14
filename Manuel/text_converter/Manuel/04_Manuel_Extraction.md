# Extraction des informations du film {#extractioninformation}

L'*extraction* est la troisième opération de la collecte, et son but ultime. Elle permet d'obtenir des séquenciers, des fichiers brins et même des statistiques sur le film.

On peut extraire :

* un résumé (ou *des* résumés partiels <sup>(*)</sup>),
* un synopsis (ou *des* synopsis partiels <sup>(*)</sup>),
* un séquencier (ou *des* séquenciers partiels <sup>(*)</sup>),
* les séquenciers de chaque brin défini (complet ou partiel <sup>(*)</sup>),
* les séquenciers de chaque brin automatique personnage (complet ou partiel <sup>(*)</sup>),
* les séquenciers de chaque brin automatique des relations de personnages (complet ou partiel <sup>(*)</sup>)

(*) On obtient une sortie *partielle* simplement en définissant le début ou la fin de l'extrait à l'aide des options `:from_time` et `:to_time`. Cf. [Définir les temps de début et de fin](#set_from_and_to_time).


## Le fichier résumé {#fichierresume}

Le *fichier résumé* présente simplement la liste des résumés de scènes assemblés bout à bout.

**En ligne de commande** :

~~~

      // forme longue
      $ collecte extract --resume

      // forme courte
      $ collecte extract -res -o=text

~~~

> Si aucun format (`-o`) n'est défini, la sortie sera en HTML.

**En programmation ruby** :

~~~ruby
      coll = Collecte.new('mon/dossier/collecte')
      coll.extract(:resume, {format: :text})
~~~

> Si aucun format n'est défini, la sortie sera en HTML.

Si la structure est définie (cf. [définition de la structure]), des retours à la ligne séparent les actes pour rendre le texte plus clair.

## Le fichier synopsis {#fichiersynopsis}

Le *fichier synopsis* présente simplement le synopsis du film, c'es-à-dire les résumés des scènes assemblés ou leurs *paragraphes* (leur *beats*) s'ils sont définis.

**En ligne de commande** :

~~~

      // forme longue
      $ collecte extract --synopsis

      // forme courte
      $ collecte extract -syn

~~~

**En programmation ruby** :

~~~ruby
      coll = Collecte.new('chemin/vers/dossier/collecte')
      coll.extract(as: :synopsis, no_horloge: true)
~~~

Par défaut, une petite horloge indiquant le temps est placée dans la marge gauche du synopsis. On peut la supprimer en ajoutant comme ci-dessus l'option `:no_horloge` à `true`.

Si la structure est définie (cf. [définition de la structure]), des doubles retours à la ligne séparent les actes.

## Les fichiers séquencier {#fichierssequencier}

Les *fichiers séquenciers* sont certainement les fichiers les plus extraits pour les analyses, notamment sous leur forme de [fichiers brins].

**En ligne de commande**

~~~bash

      // forme longue
      $ collecte extract --sequencier

      // forme courte
      $ collecte extract -seq

~~~

**En programmation ruby**

~~~ruby
      coll = Collecte.new('ma/collecte')
      coll.extract(
        as: :sequencier,
        format:   :html # par defaut
      )
~~~

Voir toutes les [options utilisables][options de collecte] avec cette commande.

## Les fichiers brins {#fichiersbrins}

TODO

### Désignation des brins {#designationbrins}

Les brins à extraire sont désignés de façon textuelle dans les options. Par exemple :

~~~
      $ collecte extract -brins=2

      $ collecte extract -brins=2+4

      $ collecte extract -brins=2,(4+12)
~~~

Ou en ruby :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as: :brins,
        brins:  '2'
      )

      coll.extract(
        as: :brins,
        brins:  '2+4'
      )

      coll.extract(
        as: :brins,
        brins:  '2,(4+12)'
      )

~~~

Pour un brin seul, on indique seulement son identifiant dans le [fichier brins].

Si on veut toutes les scènes qui appartiennent à deux brins (ou plus), on utilise le signe `+`. Noter que dans ce cas les scènes retenues sont celles qui appartiennent à TOUS les brins désignés.

Par exemple :

~~~
      $ collecte extract -b=2+4
~~~

La commande précédente crée un séquencier-brin qui contiendra toutes les scènes qui appartiennent en même temps au brin 2 ET au brin 4. Elles doivent *impérativement* appartenir aux deux brins.

Si on veut exprimer la condition `ou`, on utilise une virgule. Par exemple :

~~~
      $ collecte extract -b=2,4
~~~

La commande précédente crée un séquencier-brin qui contiendra toutes les scènes du brin 2 et toutes les scènes du brin 4 (entrelacées).

On peut créer une description complexe à l'aide des parenthèses :

~~~
      $ collecte extract -b=2+(4,12)+59
~~~

La commande précédente crée un séquencier-brin des scènes qui répondent aux conditions : appartenir impérativement au brin 2, ET appartenir impérativement au brin 59, ET appartenir impérativement au brin 4 OU au brin 12.

Avec un `+` dans la parenthèse :

~~~
      $ collecte extract -b=2,(4+5)
~~~

Crée un séquencier-brin des scènes qui appartiennent au brin 2 ou les scènes qui appartiennent au brin 4 ET au brin 5.

## Le fichier Statistiques {#fichierstatistiques}

Le *fichier statistiques* présente des statistiques sur le film, telles que le nombre de scènes, la durée moyenne par scène, le nombre de personnages, de décors, etc.

**En ligne de commande**

~~~

      // format long
      $ collecte extract --statistiques --from=0:00 --to=1:00:00

      // format court
      $collecte extract -stats -f=0:0 -t=1:0:0

~~~

> Note : la commande ci-dessus permet de ne sortir les statistiques que pour une période de temps.

**En programmation ruby**

~~~ruby
      coll = Collecte.new('ma/collecte')
      coll.extract(
        as:         :statistiques,
        from_time:  "1:00",
        to_time:    "1:0:0"
      )
~~~

Si la structure est définie (cf. [définition de la structure]), le fichier calcule aussi les écarts ou les concordances avec le *paradigme de Field augmenté*.
