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

## Formats {#troisformats}

On trouve en sortie les formats :

* **TEXT**. Un simple fichier texte rassemblant toutes les informations.
* **HTML**. Avec toutes les possibilités de définir de nombreux paramètres (cf. plus bas).
* **XML**. Un fichier XML normal, rassemblant toutes les informations.

## Options de formatage (#optionsformatage)

On trouve la description de toutes les options de formatage dans le fichier `Options.md` de ce dossier.
