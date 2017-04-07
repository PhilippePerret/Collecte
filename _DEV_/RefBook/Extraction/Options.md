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
