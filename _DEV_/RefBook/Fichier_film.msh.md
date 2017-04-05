# Le fichier `film.msh`

Ce fichier est produit à la collecte du film, il contient absolument toutes les données du film :

    @id {String}
          Identifiant du film dans le Filmodico
          TODO Il reste à déterminer comment on va le définir.

    @titre {String}
          Le titre du film, pour mémoire et simplification de
          l'affichage et l'autonomie du fichier marshal.

    @auteurs {Array de String|Fixnum}
          Liste des auteurs ayant participé à cette collecte,
          soit leur nom, soit leur identifiant sur la boite
          à outils par exemple.

    @note {String}
          Une note générale sur la collecte ou le film.

    # ------------------------------------------------
    #   É L É M E N T S   C O L L E C T É S
    # ------------------------------------------------

    @scenes {Array de Hash}
          Toutes les scènes du film, dans l'ordre
          Voir la classe Film::Scene pour voir les données
          enregistrées.

    @personnages {Hash de Hash}
          Tableau de tous les personnages récoltés dans le
          fichier de collecte `personnages.collecte`
          Key: {String} Identifiant du personnage
               C'est l'ID utilisé notamment dans la balise
               `[PERSO#<id personnage>]`
          Val: Hash des données du personnage

    @brins {Hash de Hash}
          Tableau de tous les brins récoltés dans le fichier
          de collecte `brins.collecte`
          Key: {Fixnum} Identifiant du brin
               C'est l'ID utilisé dans la marque `b<id brin>`
               utilisé dans les résumés de scènes, les
               paragraphes, les notes, etc.
          Val: Hash des données du brin

    @notes {Hash de Hash}
          Tableau de toutes les notes du film, collectées
          dans chaque scène.
          Key: L'ID de la note
          Val: Le hash des données de la note

    # ------------------------------------------------
    #   D A T E S
    # ------------------------------------------------
    @date_last_collecte {Fixnum}
          Timestamp de la date de dernière collecte.

    @created_at {Fixnum}
          Toute première création du fichier
    @updated_at {Fixnum}
          Date de dernière modification des données.
