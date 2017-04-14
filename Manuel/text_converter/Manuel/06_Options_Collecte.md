## Les différentes options de la command `collecte extract` {#optionscommandcollecte}

### Extraire des séquenciers {#extraire_sequenciers}

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
      )
~~~

> Par défaut, le format sera du HTML.

### Extraire un ou des brins {#extraire_brins}

> Rappel : un « brin » est en fait un séquencier qui se concentre sur un élément particulier de la narration. Dans le fichier de collecte des scènes, les scènes sont mises dans des brins à l'aide des marques `b<indice du brin>`. Cf. la [gestion des brins].


### Définir le temps de début et le temps de fin {#set_from_and_to_time}

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
