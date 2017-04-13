## Collecte des informations {#collectefilm}

La *Collecte* est la première opération à exécuter. Elle consiste à rassembler toutes les informations du film dans un dossier appelé *dossier de collecte*.

Ce dossier contient :

* le fichier des personnages (cf. [fichier des personnages]),
* le fichier des brins (cf. [fichier des brins]),
* le fichier des scènes (cf. [fichier des scènes]).

### Définition de la fin du film {#definirfindufilm}

Pour définir la fin du film, il faut impérativement terminer le [fichier des scènes] par :

~~~

    H:MM:SS FIN

~~~

Dans le cas contraire, le programme prendra le temps de la dernière scène et lui attribuera arbitrairement une durée de 1 minute.
