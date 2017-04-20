* Décors : ajouter le nombre de scènes par décor dans les statistiques et peut-être visualiser sur une timeline.

* Mettre en place l'utilisation (déjà documentée) des options -p (personnages) et -b (brins) pour la commande `collecte parse` qui permet de ne parser que les personnages ou que les brins.

* Mémoriser les décors (class Film::Decor, film.decors)
* Ajouter le nombre de décors aux statistiques


* Ajouter au fichier statistique :
  - le nombre de décors
  - le pourcentage de temps par personnage
  - le pourcentage de temps par décor
  - le pourcentage de temps par brin

* Indiquer qu'il ne faut pas ouvrir les fichiers log en mode test

* Implémenter la commande `collect extract --all`

* Faire une sortie de brin par personnage (ce sont les scènes d'un personnage). => Brins automatiques.
  Essayer aussi de faire les brins automatiques de relation de personnages (lorsqu'ils se trouvent au moins ensemble dans deux scènes).

* Pouvoir mettre des balises [SCENE#<horloge>]. Bien préciser dans le manuel que c'est l'horloge de la collecte, pas l'horloge réelle (bien qu'une vérification pourra être faite quand la scène ne sera pas trouvée).
  La balise sera remplacée par le numéro de la scène et en HTML par un lien qui permettra de se rendre à la scène (ou d'afficher sa fiche ? avec seulement le résumé, le temps et l'intitulé simple ?)
