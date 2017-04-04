# Liste des classes utilisées

[class Collecte]: #classe_collecte
[class Film]: #classe_film
[class Scene]: #classe_scene
[class Intitule]: #classe_intitule
[class Decor]: #classe_decor
[class Note]: #classe_note

[class RelativeObject]: #classe_objet_relatif
[objet relatif]: #classe_objet_relatif


## Collecte {#classe_collecte}

C'est la classe principale d'une collecte.

Ses propriétés principales sont :

    @film         Instance {Film} de la collecte
    @folder       {String} Le path au dossier de la collecte
    @start_time   {Fixnum} Le temps de départ de la toute première
                  scène de la collecte/du film.

## Film {#classe_film}

Classe pour le film concerné par la collecte.

Propriétés principales :

    @collecte   Instance {Collecte} de la collecte
    @scenes     Array des instances {Film::Scene}, dans l'ordre
    @id         {String} Identifiant du film, le même que pour le
                scénodico.
    @decors     {Hash} Tableau des décors du film, avec en clé
                l'identifiant unique du décor ({Fixnum}) et en
                valeur son instance {Film::Decor}.

## Film::Scene {#classe_scene}

Classe pour une scène de la collecte, donc du film.

Cette classe possède les propriétés principales :

    @film         Instance {Film} du film de la scène
    @id           {Fixnum} ID unique de la scène
    @numero       {Fixnum} Numéro de la scène. Il peut être ≠ de
                  l'ID, s'il y a des scènes prégénériques par
                  exemple.
    @intitule     Instance {Film::Scene::Intitule} de son intitulé
    @resume       {String} Le résumé de la scène
    @paragraphes  La liste des {Film::Scene::Beat} de la scène.
    @notes        Liste des Notes (instances Film::Note)
    @brins        Liste des brins (instances Film::Brin)
    @personnages  Liste des personnages (instances Film::Personnage)

    # Raccourcis de l'intitulé
    @horloge      {String} Horloge réelle de la scène
    @time         {Fixnume} Temps réel de la scène

## Film::Scene::Intitule {#classe_intitule}

Classe pour un intitulé de scène.

Propriétés principales :

    @scene        Instance {Film::Scene} de la scène de l'intitulé
    @horloge      {String} L'horloge de l'intitulé
    @effet        {String} Effet de la scène
    @effet_alt    {String} Effet alternatif, s'il y en a deux
    @lieu         {String} Lieu de la scène
    @lieu_alt     {String} Lieu alternatif, s'il y en a deux
    @decor        {Film::Decor} Décor de la scène
    @decor_id     {Fixnum} ID du décor de la scène
    @decor_alt    {Film::Decor} Décor alternatif, si deux décors
    @decor_alt_id {Fixnum} ID du décor alternatif de la scène

## Film::Decor {#classe_decor}

Classe pour les décors du film. Chaque fois qu'un nouveau décor est rencontré dans la collecte, une instance de cette classe est créée et ajoutée au tableau `@decors` des décors du film.

## Film::RelativeObject {#classe_objet_relatif}

Classe héritée de tous les objets en relation avec les scènes ou autres que sont les [class Note], les [class Brin] ou autre [class Personnage].

Propriétés principales :

    @scenes_ids

    # Propriétés volatiles
    # --------------------
    @scenes

## Film::Note {#classe_note}

Classe pour une note.

C'est un [objet relatif] donc il possède toutes les propriétés de ces objets.

Propriétés principales :

    @id             {Fixnum} ID unique de la note dans le film.
    @content        {String} Contenu de la note.
    @scene_id       {Fixnum} ID de la scène de cette note, entendu
                    que dans une collecte toutes les notes sont
                    associées à des scènes.
                    Note : c'est la scène où est définie la note,
                    mais elle peut être utilisée dans d'autres
                    scènes.

    # Propriétés volatiles
    # --------------------
    @scene          {Film::Scene} Instance de la scène de la note

    # Propriétés partagées par tous les RelativeObjects
    # -------------------------------------------------
    @scenes_ids     {Array de Fixnum} Liste des ID de scènes qui
                    sont en relation avec cette note.
    @scenes         {Array de Film::Scene} Instances de toutes les
                    scènes en relation avec cette notes.


## Film::Brin {#classe_brin}

## Film::Personnage {#classe_personnage}

Classe pour les personnages du film.

Propriétés principales :

    @id               {String} ID du personnage. P.e. "jon"
    @prenom           {String} Prénom du personnage
    @nom              {String} Nom du personnage
    @fonction         {String} Fonction du personnage
    @description      {String} Description du personnage

    @scenes_ids       {Array de Fixnum} Liste des ID de scènes.

    # Propriétés volatiles
    # --------------------
    @scenes           {Array de Film::Scene} Liste des scènes
