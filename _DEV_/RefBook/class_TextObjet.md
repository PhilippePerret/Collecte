# Classe TextObjet

La classe `TextObjet` permet de gérer les textes qui peuvent contenir des marques de personnage, appartenir à des brins, être annotés, etc.

Un résumé ou un paragraphe de scène est en priorité de cette classe.

Exemple typique de texte-objet :

    1:12:23 [PERSO#joe] revient chez lui avec [PERSO#jan]. (12) b25

Cet objet est introduit par une horloge (« 1:12:23 », propriété `@horloge`) et donc un temps (1x3600 + 12x60 + 23, `@time`). Il appartient aux personnages `joe` et `jan` (`@personnages_ids` = `['joe', 'jan']`), il appartient au brin `#25` (`@brins_ids` = `[25]`) et il a la note `12` (`@notes_ids` = `[12]`).

## Propriétés du TextObjet

    @raw              
      {String} Le code initial, tel qu'il se trouve dans le
      fichier de collecte.
    @horloge
      {Film::Horloge} Horloge du texte-objet.
    @to_str           
      {String} L'objet tel qu'il sera affiché dans un
      affichage simple, textuel.
    @to_html
      {String} L'objet tel qu'il sera affiché en version HTML.
      Ici, tous les éléments (personnages, notes, etc.) sont
      liés à leur donnée.
    @personnages_ids  
      {Array de String} Liste des identifiants de personnages.
    @brins_ids
      {Array de Fixnum} Liste des identifiants de brins.
    @notes_ids
      {Array de Fixnum} Liste des identifiants de notes.
    @scene_id
      {Fixnum} Identifiant de la scène à laquelle appartient
      le texte-objet.
    @scenes_ids
      {Array de Fixnum} Liste des identifiants de scènes.

    # Propriétés volatiles
    # --------------------

    @personnages  Liste des personnages de l'objet.

## Méthode #to_str

La méthode `to_str` permet de gérer cette classe comme un string normal.
