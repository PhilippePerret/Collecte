# Gestion des messages

Pour sortir un fichier HTML (qui s'ouvrira automatiquement à la fin des opérations) avec tous les messages log et les messages d'erreur, il suffit d'ajouter l'option `:debug` à true.

Par exemple pour le parsing :

~~~
  coll = Collecte.new('mon/dossier/collecte')
  coll.parse(debug: true)
~~~

Par exemple pour l'extraction :

~~~
  coll = Collecte.new('mon/dossier/collecte')
  coll.extract(format: :html, as: :sequencier, debug: true)
~~~


Noter que le fichier journal `log.html` est automatiquement ouvert lorsqu'une erreur a été produite.
