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

Si les actes sont définis (cf. [définition des actes]), un retour à ligne est ajouté à chaque changement d'acte.

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

> Cf. la [désignation des brins].

**Programmation ruby**

~~~ruby
      coll = Collecte.new('dossier/collecte')
      coll.extract(
        as:     :brins,
        brins:  '<designation>'
      )
~~~

> Cf. la [désignation des brins].


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

## Forcer le parsing avant l'extraction {#forcerparsing}

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
