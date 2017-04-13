* Mettre en place l'extraction des statistiques
  as: :statistiques
  
* Poursuivre le manuel (./Manuel/Manuel.md) et le transformer avec TextConverter en fichier HTML et PDF.

* Mettre en place l'application Collecte
  Il reste à traiter les choses dans le fichier /Applications/Collecte.app/Contents/MacOS/Collecte. Appeler simplement un script se trouvant dans ce dossier (en se plaçant à la racine de cette application pour n'avoir ensuite qu'à déplacer tout ce code dans l'application).
* Produire un fichier statistique qui rassemble :
  - le nombre de décors
  - le nombre de personnages
  - le nombre de scènes
  - la durée de la scène la plus longue
  - la durée de la scène la plus courte
  - la durée moyenne des scènes
  - le pourcentage de temps par personnage
  - le pourcentage de temps par décor
  - le nombre de brins
  - le pourcentage de temps par brin
  Note : il faut rassembler les décors pour pouvoir calculer ces temps. Penser aux decor_alt aussi.

* Ne pas ouvrir les fichiers log en mode test

* Faire un méthode extract(format) qui extrait tous les éléments du film
  - le séquencier complet
  - le synopsis complet
  - tous les brins
  - tous les brins par personnage et relation
  - la liste complète des informations
* Voir une version complète du séquencier avec les paragraphes des scènes

* Faire une sortie de brin par personnage (ce sont les scènes d'un personnage). => Brins automatiques.
  Essayer aussi de faire les brins automatiques de relation de personnages (lorsqu'ils se trouvent au moins ensemble dans deux scènes).

* Faire la commande script `collecte`

* Dans le RefBook, faire un manuel d'utilisation

* Pouvoir mettre des balises [SCENE#<horloge>]. Bien préciser dans le manuel que c'est l'horloge de la collecte, pas l'horloge réelle (bien qu'une vérification pourra être faite quand la scène ne sera pas trouvée).
  La balise sera remplacée par le numéro de la scène et en HTML par un lien qui permettra de se rendre à la scène (ou d'afficher sa fiche ? avec seulement le résumé, le temps et l'intitulé simple ?)
