# Extraction

La troisième opération consiste à extraire les fichiers qui viennent de la collecte.

On peut extraire :

* un résumé (ou *des* résumés partiels <sup>(*)</sup>),
* un synopsis (ou *des* synopsis partiels <sup>(*)</sup>),
* un séquencier (ou *des* séquenciers partiels <sup>(*)</sup>),
* les séquenciers de chaque brin défini (complet ou partiel <sup>(*)</sup>),
* les séquenciers de chaque brin automatique personnage (complet ou partiel <sup>(*)</sup>),
* les séquenciers de chaque brin automatique des relations de personnages (complet ou partiel <sup>(*)</sup>)

(*) On obtient une sortie *partielle* simplement en définissant le début ou la fin de l'extrait à l'aide des options `:from_time` et `:to_time`.

## Extraire tous les fichiers d'un coup {#extractallonetime}

On peut sortir tous ces fichiers d'un coup en utilisant le script :

      Collecte/___/extraction/extract_all.rb

… ou en jouant dans le dossier de collecte la commande `collecte --all` :

    cd mon/dossier/collecte
    collecte extract --all
