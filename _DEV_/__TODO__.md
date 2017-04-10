* Faire la classe principale "FFile"
* Puis HTMLFile < FFile
  Contient notamment un gabarit qui permet de faire le fichier facilement.
* Puis film.error_file << HTMLFile pour sortir les erreurs

* Signaler lorsque le nombre de scènes attendu (expected_scenes_count) ne correspond pas au nombre de scènes obtenues (film.scenes.count)
* Mettre un nom différent quand c'est une suggestion de la structure.

* Faire des propositions de découpe (position/divisions des scènes clés, etc.). options: :suggest_divisions (documenter)

* Pouvoir mettre des balises [SCENE#<horloge>]. Bien préciser dans le manuel que c'est l'horloge de la collecte, pas l'horloge réelle (bien qu'une vérification pourra être faite quand la scène ne sera pas trouvée).
  La balise sera remplacée par le numéro de la scène et en HTML par un lien qui permettra de se rendre à la scène (ou d'afficher sa fiche ? avec seulement le résumé, le temps et l'intitulé simple ?)
