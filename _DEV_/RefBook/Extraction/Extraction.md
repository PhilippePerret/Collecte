# Extraction des données

Après avoir procédé à la collecte des informations, puis à leur parsing (`Collecte#parse`), on peut extraire les données pour en tirer des fichiers.

La forme de base est :

~~~

  coll = Collecte.new('mon/dossier/collecte')

  # Les données ont été parsées par :
  # coll.parse
  # Si ça n'est pas le cas, la procédure de parsing
  # est lancée pour construire le fichier Marshal qui
  # consignent les données (film.msh).

  # Extraction dans un format simple text
  coll.extract(format: :text)

~~~

Cette formule est un raccourci de :

~~~

    coll.extractor(:text).extract_data

~~~

## Formats de sortie {#troisformats}

On trouve en sortie les formats :

* **TEXT**. Un simple fichier texte rassemblant toutes les informations.
* **HTML**. Avec toutes les possibilités de définir de nombreux paramètres (cf. plus bas).
* **XML**. Un fichier XML normal, rassemblant toutes les informations.

## Type de sortie {#typeoutput}

Le type de sortie se définit par la propriété `:as` en option.

Cette propriété peut avoir les valeurs :

* Aucune. C'est alors une sortie brute des données, qui peut servir pour des vérifications.
* `:sequencier`. Sort un séquencier, en HTML principalement.

### Sortie des brins {#brinsensortie}

Sortir un brin correspond à définir une sortie en séquencier avec un filtre sur les brins. Donc :

~~~

  coll = Collecte.new('mon/dossier/collecte')
  coll.parse # Pour parser les données
  coll.extract(
    as: :sequencier,
    from_time: '0:12:00', to_time: '1:12:00',
    filter: {brins: [2,45]}
    )
  # =>  Produit un séquencier ne contenant que les scènes
  #     de la 12e minute à 1 heure 12 qui appartiennent aux
  #     brins 2 et 45
  
~~~

## Options de formatage (#optionsformatage)

On trouve la description de toutes les options de formatage dans le fichier `Options.md` de ce dossier.
