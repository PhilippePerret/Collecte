# Les différentes options de la command `collecte extract` {#optionscommandcollecte}

## Extraire tous les fichiers {#extrairetousfichiers}

On peut, à l'aide d'une unique commande, extraire tous les fichiers d'analyse, c'est-à-dire :

* le séquencier complet,
* le résumé complet,
* le synopsis complet avec horloge,
* tous les séquenciers des brins (appelés « fichiers brins »),
* le fichier statistiques.

**Options en ligne de commande**

~~~
      --all
      -a
~~~

Par exemple :

~~~
      collecte extract --all
      ou
      collecte extract -a
~~~

> Noter que si le parsing n'a pas eu encore lieu il sera exécuté avant l'extraction.

**Options en ruby**

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(:all)
~~~

> Le format de sortie sera HTML. Pour un autre format (`:text` ou `:xml`, mettre en second argument `format: :<format>`).


## Extraire le résumé {#extraireresume}

Le fichier « résumé » est un fichier qui ne reprent que les résumés des scènes et les assemble l'un au bout de l'autre.

**Options ligne de commande**

~~~
      // forme longue
      $ collecte extract --resume

      // forme abregee
      $ collecte extract -res
~~~

**Options en ruby**

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as:   :resume
      )
~~~

Si les actes sont définis (cf. [définition des actes]), une séparation est ajoutée à chaque changement d'acte.

## Extraire le synopsis {#extrairesynopsis}

**Options ligne de commande**

~~~
      // forme longue
      $ collecte extract --synopsis

      // forme abregee
      $ collecte extract -syn
~~~

**Programmation ruby**

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as: :synopsis
      )
~~~

**Autres options**

~~~

      :no_horloge     Supprime les horloges si true

      // Commande
      $ collect extract -syn --no_horloge

      // Ruby
      coll.extract(
        as:         :synopsis,
        no_horloge: true
      )

~~~

> Note : comme pour les résumés, si les actes sont définis (cf. [définition des actes]), une séparation est faite suivant les différentes parties.

## Extraire des séquenciers {#extraire_sequenciers}

Pour produire des séquenciers, c'est-à-dire des fichiers comportant les scènes et les intitulés, utiliser l'option `--sequencier` ou `-seq`.

**Options lignes de commande**

~~~
      --sequencier
      -seq
~~~

Par exemple, pour produire un séquencier à partir de la 10<sup>ème</sup> minute réelle :

~~~
      $ collecte extract -seq -f=10:00
~~~

**Options en ruby**

~~~ruby
      as: :sequencier
~~~

Exemple :

~~~ruby
      Coll = Collecte.new('mon/dossier/collecte')
      Coll.parse # si necessaire
      Coll.extract(
        as: :sequencier,
        from_time: '10:0'
      )
~~~

> Par défaut, le format sera du HTML.

## Extraire un ou des brins {#extraire_brins}

> Rappel : un « brin » est en fait un séquencier qui se concentre sur un élément particulier de la narration. Dans le fichier de collecte des scènes, les scènes sont mises dans des brins à l'aide des marques `b<indice du brin>`. Cf. la [gestion des brins].

**Options ligne de commande**

~~~

      // forme longue
      $ collecte extract --brins=<designation>

      // forme abregee
      $ collecte extract -b=<designation>

~~~

Pour produire tous les brins, on utilise `--brins` seul, sans argument :

~~~
      $ collecte extract --brins
~~~


> Cf. la [désignation des brins].

**Programmation ruby**

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as:     :brins,
        brins:  '<designation>'
      )
~~~

> Cf. la [désignation des brins] pour voir comment désigner les brins à voir.

Exemple :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as:     :brins,
        brins:  '2+(4,12)'
      )
~~~


## Extraire le fichier statistiques {#extraire statistiques}

Le fichier *statistiques* contient des données statistiques sur le film, telles que le nombre de scènes, leur durée moyenne, les temps de présence des personnages, etc.

**Options en ligne de commande**

~~~
      --statistiques ou -stats
~~~

Par exemple :

~~~
      $ collecte extract -stats
~~~

**Programmation ruby**

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(as: :statistiques)
~~~

> On peut tout à fait obtenir les statistiques seulement pour une portion de temps, ou pour un brin en particulier, en définissant ces paramètres.

## Définir le temps de début et le temps de fin {#set_from_and_to_time}

Pour tous les fichiers extraits, on peut définir le temps de départ à l'aide des options `from` et `to` qui doivent définir une horloge `H:MM:SS`.

**Options ligne de commande**

~~~
      --from=<horloge>(*)  Depuis ce temps réel (**)
      -f=<horloge>

      --to=<horloge>       À ce temps réel (**)
      --t=<horloge>
~~~

(*) Voir le [formatage des horloges].<br>
(**) Voir l'[explication sur les temps réels et relatifs].

Exemple :

~~~
      $ collecte extract --all --from=0:12 --to=1:12:00
~~~

Avec la commande précédente, tous les fichiers seront extraits, entre la 12ème minute et 1 heure 12. On peut utiliser aussi la formule d'option courte :

~~~
      $ collecte extract -a -f=0:12 -t=1:12:00
~~~

**Options en ruby**

~~~ruby
        :from_time  => "<horloge>"
        :to_time    => "<horloge>"
~~~

Exemple :

~~~ruby
      coll = Collection.new('mon/dossier/collecte')
      coll.extract(
        format:     :html,
        as:         :sequencier,
        from_time:  '0:12',
        to_time:    '1:25:56'
      )
~~~

## Définir le format de sortie {#setformatsortie}

Pour le moment, la sortie la plus sûre est en `HTML` (format par défaut), mais elle le sera plus tard en `XML` et en `TEXT`.

**Options en ligne de commande**

~~~
      --html  ou  --output_format=html  ou -o=html
      --xml   ou  --output_format=xml   ou -o=xml
      --text  ou  --output_format=text  ou -o=text
~~~

Par exemple :

~~~
      $ collecte extract --all --xml
      ou
      $ collecte extract -a -o=xml
~~~

**Programmation ruby**

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(:all, format: :xml)
~~~

## Options de l'extraction {#optionsextraction}

### Option : ne pas afficher la timeline {#option_notimeline}

Par défaut, lorsque l'on produit un séquencier en `html`, une *timeline* est écrite en haut du document, qui permet de visualiser l'emplacement des scènes.

Cette timeline peut être supprimée à l'extraction avec l'option `--no_timeline` ou `-ntl`.

Par exemple, en ligne de commande :

~~~
      $ collecte extract -seq --no_timeline
~~~

En ruby :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as: :sequencier,
        no_timeline: true
      )
~~~

### Option : suggérer la structure {#option_suggeststructure}

Au moment de l'analyse, avant le placement des [points structurels], il peut être intéressant de demander à l'extraction de suggérer les positions de ces points structurels (mettre en relief les quarts-temps, les tiers-temps, etc.).

Pour ce faire, on utilise l'option `--suggest_structure` ou `--stt`.

Par exemple, en ligne de commande :

~~~
      $ collecte extract --sequencier --suggest_structure
      ou
      $ collecte extract -seq -stt
~~~

Ou en ruby :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as: :sequencier,
        suggest_structure: true
      )
~~~

### Option : forcer le parsing avant l'extraction {#forcerparsing}

Parfois des données sont modifiées dans les fichiers de collecte. Mais si un *parsing* a déjà eu lieu, les nouvelles données ne seront pas prises en compte. Pour qu'elles le soient, il faut *forcer à novueau le parsing*. On utilise pour ça l'option `force_parsing`.

**Options en ligne de commande**

~~~
      --force_parsing
      -fp
~~~

Par exemple :

~~~
      $ collecte extract -a -fp
      // ou
      $ collecte extract --all --force_parsing
~~~

> La commande précédente extrait tous les fichier (`-a`) en forçant le parsing des données (`-fp`)

**Option en ruby**

~~~ruby
      :force_parsing
~~~

Par exemple :

~~~ruby
      coll = Collecte.new('mon/dossier/collecte')
      coll.extract(:all, force_parsing: true)

      # ou

      coll.extract(
        as:             :sequencier,
        format:         :xml,
        force_parsing:  true
      )
~~~

### Option : mettre une horloge au synopsis {#option_horloge_synopsis}

On peut ajouter une horloge en regard des scènes du synopsis, pour les situer dans le temps, à l'aide de l'option `--horloge` ou `-h`.

Par exemple, en ligne de commande :

~~~
      $ collecte extract --synopsis --horloge
      ou
      $ collecte extract -syn -h
~~~

Ou en ruby :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as:       :synopsis,
        horloge:  true
      )
~~~

### Option : ouvrir le fichier extrait {#option_ouvrirfichierextrait}

On peut ouvrir directement le fichier produit, en fin d'extraction, à l'aide de l'option `--open_file` ou `-open`.

Par exemple :

~~~
      $ collecte extract --brins=2 --open_file
      ou
      $ collecte extract -b=2 -open
~~~

Ou en ruby :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as:         :brin,
        brins:      '2',
        open_file:  true
      )
~~~

### Option : débugger {#option_debugger}

On peut ouvrir le fichier log en fin d'opération (parsing, extraction) à l'aide de l'option `--debug` ou `-d`.

Par exemple, en ligne de programme :

~~~
      $ collecte parse --debug
      ou
      $ collecte parse -d
~~~

Ou, en ruby :

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.parse(debug: true)
~~~
