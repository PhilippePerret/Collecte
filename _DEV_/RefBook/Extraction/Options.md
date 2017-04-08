# Options d'extraction {#optionsextraction}

Ce fichier contient la description des options qu'on peut passer à la méthode `Collecte#extract` pour spécifier la sortie qu'on veut obtenir.

~~~

  :format
      Le format de sortie, parmi :html, :text, :xml.

  :path
      Le path éventuel du fichier produit. Par défaut, ce
      sera.

  :open_file
      Si true, le fichier produit sera ouvert à la fin de sa
      construction.

~~~

## Options propres au format HTML {#optionsformathtml}

C'est le format HTML qui permet de produire le plus de sorties différentes.

~~~

  :full_file      defaut : true
      Si true, un fichier complet est produit, c'est-à-dire
      un fichier HTML autonome qui peut être chargé dans
      un navigateur pour être visualisé.
      Si false, c'est seulement le code propre à ce qu'il
      faut afficher qui est produit. Le nom du fichier ne
      porte pas, alors, le suffixe '_FULL'.

  :from_time      defaut : nil
      Temps de départ. Pour n'afficher qu'une portion du film.
  :to_time        defaut : nil
      Temps de fin. Pour n'afficher qu'une portion du film.

~~~

## Options pour les séquenciers {#options_sequenciers}

> Il s'agit donc aussi des brins, qui sont des séquenciers particuliers.

### Options pour l'intitulé {#options_intitule_sequenciers}

On peut décider des éléments à faire apparaitre dans l'intitulé à l'aide des options :

~~~

  :no_horloge       Pas d'horloge.
  :no_numero        Pas de numéro de scène.
  :no_lieu          Pas de lieu (INT/EXT) mais le décor oui.
  :no_decor         Pas de décor
  :no_effet         Pas d'effet (JOUR/NUIT)

~~~

Par défaut, l'intitulé est dans cet ordre :

~~~
  HORLOGE NUMÉRO LIEU DÉCOR EFFET
~~~

On peut utiliser un format propre en définissant dans les options la propriété `:intitule` et en en faisant un template.

~~~

  # Par défaut :
  intitule: "%{horloge}%{numero}%{lieu}%{decor}%{effet}"

~~~


On peut avoir par exemple :

~~~

  options = {
    intitule: "%{numero}.%{lieu}/%{effet}"
  }

~~~

On peut bien entendu définir tout ce qu'on veut dans ce template, pourvu que ça s'affiche. Par exemple, pour placer juste un numéro et l'horloge flottante à droite :

~~~

  options = {
    intitule: "<span style='float:right'>%{horloge}</span>%{numero}"
  }
~~~

> Note : il est inutile de mettre les éléments de l'intitulé dans leur span (par exemple `<span class="horloge">`) car ils sont ajoutés automatiquement. À partir du moment où le programme voit `%{propriété intitulé}`, il l'entoure de son span en HTML.
