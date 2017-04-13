[fichier des scènes]: #fichier_des_scenes
[fichier des personnages]: #fichier_des_personnages
[fichier des brins]: #fichier_des_brins

# Manuel d'utilisation de Collecte

* Pour la table des matières
{:toc}

## Collecte des informations {#collectefilm}

La *Collecte* est la première opération à exécuter. Elle consiste à rassembler toutes les informations du film dans un dossier appelé *dossier de collecte*.

Ce dossier contient :

* le fichier des personnages (cf. [fichier des personnages]),
* le fichier des brins (cf. [fichier des brins]),
* le fichier des scènes (cf. [fichier des scènes]).

## Parsing de la collecte {#parsingcollecte}

Le *parsing* est l'opération qui consiste à transformer les données collectées dans l'étape précédente en données utilisables pour créer des fichiers d'analyse, des statistiques, etc.

Pour parser un dossier de collecte, le plus simple est d'utiliser dans le Terminal la commande :

    collecte parse mon/dossier/collecte

Ou de le faire par ruby :

    coll = Collecte.new('mon/dossier/collecte')
    coll.parse
    

## Extraction des informations du film {#extractioninformation}

L'*extraction* est la troisième opération de la collecte, et son but ultime. Elle permet d'obtenir des séquenciers, des fichiers brins et même des statistiques sur le film.
