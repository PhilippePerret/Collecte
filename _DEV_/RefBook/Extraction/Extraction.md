# Extraction des données

Après avoir procédé à la collecte des informations, puis à leur parsing (`Collecte#parse`), on peut extraire les données pour en tirer des fichiers.

## Utilisation des scripts d'extraction {#scriptsextraction}

Pour ne pas passer par la programmation, on peut se servir des scripts prêts-à-l'emploi dans le dossier `___/extraction/`.

Il suffit de choisir le type d'extraction (vers séquencier, synopsis, etc.) puis de définir les constantes voulues.

## Extraction par programmation {#extractionparprogrammation}

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
* `:brin`. Sort un brin, c'est-à-dire toutes les scènes appartenant à ce ou ces brins. En vérité, ce format consiste à sortir un séquencier avec un filtre sur les brins.
* `:synopsis`. Sort un synopsis. Un synopsis consiste en un listing simple des résumés et/ou des paragraphes de scènes, sans horloge (sans indications contraire, mais discrètes).

### Sortie des brins {#brinsensortie}

Pour sortir un brin :

~~~

  coll = Collecte.new('mon/dossier/collecte')
  coll.parse # si nécessaire
  coll.extract(as: :brin, brin: 12)
  # => Extrait le fichier "brin_12.html"

~~~

Sortir un brin correspond à définir une sortie en séquencier avec un filtre sur les brins. Donc :

~~~

  coll = Collecte.new('mon/dossier/collecte')
  coll.parse # Pour parser les données
  coll.extract(
    as: :sequencier,
    from_time: '0:12:00', to_time: '1:12:00',
    filter: {brins: '2+45'}
    )
  # =>  Produit un séquencier ne contenant que les scènes
  #     de la 12e minute à 1 heure 12 qui appartiennent aux
  #     brins 2 ET 45

~~~

## Raccourcis pour extraction

On peut transmettre à la méthode `Collecte#extract` un `Symbol` au lieu d'un `Hash` pour certaines sorties.

Par exemple :

~~~
  coll = Collecte.new('mon/dossier/collecte')
  coll.extract(:sequencier_html)
  # => Produit le séquencier complet HTML du film
~~~

Les valeurs possibles sont :

~~~

  :sequencier         Version TEXT du séquencier complet
  :sequencier_html    Version HTML du séquencier complet
  :all_brins          Version TEXT de tous les brins
                      (un seul fichier)
  :all_brins_html     Versions HTML de tous les brins
                      (un fichier par brin, avec le nom
                       contenant l'id du brin)
~~~

Ces formats sont définis dans le fichier `.lib/required_then/classe/Collecte/Collecte/instance/extract_methods.rb`, méthode `options_arg_to_real_options`.


## Options de formatage (#optionsformatage)

On trouve la description de toutes les options de formatage dans le fichier `Options.md` de ce dossier.
