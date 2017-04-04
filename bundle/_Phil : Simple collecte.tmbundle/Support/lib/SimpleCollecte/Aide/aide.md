## Présentation de la collecte simple {#presentation}

La *collecte simple* permet de collecter les scènes, les brins et les personnages d'un film de façon simple, avec un format de fichier simplifié.

Ces données simples sont :

* le temps,
* le lieu, l'effet et le décor,
* le résumé,
* les personnages,
* les brins auxquels appartient la scène ou ses parties.

> Pour une version plus complète d'une collecte des scènes d'un film, utiliser plutôt les outils du bundle `__Phil_Film`.

Les données collectées peuvent être ensuite traitées par l'outils de la Boite à outils de l'auteur (cf. [Extraction des données]).


<!--

      RÉSUMÉ DE LA PROCÉDURE

-->

## Résumé de la procédure de collecte simple {#resume_procedure}

* Créer un dossier pour mettre les fichiers (cf. [Créer le dossier du film]) ;
* ouvrir ce dossier dans Textmate ;
* [créer le fichier des personnages] (commande `Personnage : Créer le fichier`) et [définir les personnages] (snippet `perso`) ;
* [créer le fichier des brins] (commande `Brin : Créer le fichier`) et [définir les brins] (snippet `brin`) ;
* [créer le fichier des scènes] ;
* caler le film quelques secondes avant la portion à collecter ;
* <a href="#suivre_automatiquement_temps">régler le temps de début de collecte au temps du film</a> (`H:MM:SS:start`) et <a href="#start_collecte">lancer l'horloge de suivi</a> (`...:start[TAB]`) en même temps que le film ;
* créer une nouvelle scène (snippet `s`) ;
* répéter la création de nouvelles scènes pour chaque nouvelle scène ;
* finir la collecte ;
* procéder à l’[extraction des données][Extraction des données].



<!--

          DOSSIER DU FILM

-->

## Dossier de collecte du film {#dossier_collecte_film}

### Créer le dossier du film {#creer_dossier_film}

On peut créer le dossier de collecte n'importe où.

C'est ce dossier qui contiendra tous les fichiers de la collecte simple, à commencer par le [fichier des scènes], le [fichier des personnages] et le [fichier des brins].

Donner à ce dossier le nom-identifiant du film.

Puis l'ouvrir dans TextMate en le glissant sur son icône dans le dock par exemple.

<!--

          FICHIER DES SCÈNES

-->

## Le fichier des scènes {#fichier_scenes}

Son nom doit être impérativement `scenes.simple_collecte`.

### Composition du fichier {#composition_fichier}

Le fichier de collecte des scènes en version simple est composé de trois éléments :

* Une ligne d'information contenant le temps, le lieu, l'effet et le décor ;
* Une ligne avec le résumé de la scène ;
* Optionnellement : des paragraphes servant de synopsis détaillé ;
* Optionnellement : les brins auxquels appartient la scène (cf. [Insérer la scène dans des brins]).

Dans un fichier peut ressembler à :

<document>
  <div>0:12:23 EXT. JOUR COUR D'ÉCOLE</div>
  <div>PERSO[Patrick] rentre dans l'école.</div>
  <div>PERSO[Patrick] se gare sur le parking de l'école et sort de sa voiture.</div>
  <div>PERSO[Patrick] traverse le parking et disparait dans l'école.</div>
  <div>B12 B25</div>
  <div> </div>
  <div>0:13:45 INT. JOUR SALLE DE CLASSE</div>
  <div>Une salle de classe déserte.</div>
  <div>B25</div>
  <div> </div>
  <div>etc.</div>
</document>

### Créer le fichier des scènes {#create_file_scenes}

Le plus simple, pour créer le fichier des scènes, est d'utiliser la commande `Scène : Créer le fichier`.

Pour se faire, il suffit de se trouver dans le [dossier de collecte] ouvert dans TextMate.

### Définir facilement la ligne d'info de la scène {#snippet_ligne_info}

Le snippet `int[TAB]` permet d'entrer facilement la ligne d'info de la scène comportant le temps, le lieu, l'effet, le décor et le résumé de la scène.

On peut même faire que TextMate se charge de définir le temps lui-même (cf. [Définir les temps de façon automatique]).

Sinon, on peut aussi définir cette ligne en ajoutant chaque élément dans le bon ordre :

<center>`TEMPS LIEU EFFET DÉCOR`</center>

Par exemple :

<document>
  <div>0:12 INT. JOUR MAISON</div>
  <div>Le résumé de la scène.</div>
  ...
</document>


### Définir les temps de façon automatique {#suivre_automatiquement_temps}

La procédure rapide est la suivante :

* Caler la lecture du film à un temps donné (quelques secondes avant la portion à collecter) ;
* Écrire ce temps de calage à la fin du <a href="#fichier_scenes">fichier des scènes</a> puis ajouter le snippet `:start`. Par exemple : `0:00:30:start` (si le film est calé sur sa 30<sup>ème</sup> seconde) ;
* Se placer juste après `start` et jouer la tabulation en déclenchant le film en même temps ;
{: #start_collecte}
* Insérer les scènes de la même manière en tapant `s[TAB]`.

> Par défaut, le programme retire 3 secondes au temps, en considérant que la scène a été créée environ 3 secondes après son départ à l'écran.

> Attention, ce snippet **n'ajoute pas de scène** au fichier. Au moment où la scène arrive, il faut jouer `s[TAB]` pour qu'une nouvelle scène soit initiée.


<!--
    I N T R O D U I R E   S C È N E   D A N S   U N   B R I N
-->

### Introduire la scène dans des brins {#introduire_dans_brin}

Pour introduire la scène dans un brin, on ajoute des marques `B&lt;id du brin&gt;` sur la dernière ligne de la scène.

On peut également ajouter ces marques à la fin de chaque paragraphe de la scène pour les introduire dans des brins.

### Utiliser un personnage dans le résumé {#inserer_personnage}

Si le [fichier des personnages] est défini, on peut entrer facilement des personnages à l'aide du snippet `p[TAB]`.

À l'endroit voulu, taper ce snippet fera apparaitre la liste des personnages et il suffira de choisir celui qu'on veut insérer.

### Ajouter une note {#inserer_note}

On peut ajouter une note à la scène complète ou à un paragraphe seulement. Pour l'ajouter à la scène complète, il faut mettre sa marque à la fin de la seconde ligne (donc la ligne de résumé), sinon, il faut l'ajouter à la fin du paragraphe concernant la note.

Cette note s'ajoute grâce au snippet `n`, qui cherche un indice de note unique pour créer la marque `(<indice de note>)` à placer à la fin du paragraphe et à la fin de la scène pour définir la note.
  
Ensuite, cette note doit être définie dans les lignes suivantes, par une ligne commençant par `(<indice de note>) <La note>`. Cette ligne doit être placée avant la dernière ligne qui comprend les relatifs de la scène (principalement les brins).
  
Par exemple :

<document>
  <div>0:12:23 INT. JOUR MAISON DE JOE</div>
  <div>Joe rentre chez lui. (12)</div>
  <div>On entend la voiture de Joe arriver, ses phrases éclairent la pièce.</div>
  <div>On entend le bruit d'une portière, puis des pas hésitant. (45)</div>
  <div>La porte s'ouvre, Joe apparait, en sang.</div>
  <div>(12) C'est une note concernant toute la scène.</div>
  <div>(45) C'est une note concernant seulement le deuxième paragraphe.</div>
  <div>b4 b15</div>
</document>

Ci-dessus, les notes `12` et `45` ont été ajoutées.

### Faire référence à une note {#reference_a_note}

Pour faire référence à une note, il suffit d'utiliser `(<indice de note)`. Par exemple :

<document>
  <div>…</div>
  <div>(15) Pour comprendre cette note, voir la note (12) de la scène suivante.</div>
  <div>…</div>
</document>

Ci-dessus, on définit la note `15` qui fait référence à la note `12`.

<!--

        B R I N S

-->

## Le fichier des brins {#fichier_brins}

Le fichier des brins permet de consigner tous les brins du film.

Son nom doit être impérativement `brins.simple_collecte`.

### Créer le fichier des brins {#create_file_brins}

La commande `Brin : Créer le fichier` permet de créer le fichier brin. Il suffit d'ouvrir le dossier de la collecte dans TextMate puis d'activer cette commande pour le créer.

Sinon, créer le fichier `brins.simple_collecte` dans le [dossier de collecte].

### Définir les brins {#create_brin}

Le snippet `brin` permet de créer un brin dans le [fichier des brins]. Il suffit donc d'activer ou de [créer ce fichier][Créer le fichier des brins] puis de taper `brin` suivi d'une tabulation pour créer un nouveau brin.

> Noter que les brins s'incrémenteront automatiquement, il est inutile de préciser l'identifiant.

<!--

          P E R S O N N A G E S

-->

## Le fichier des personnages {#fichier_personnages}

Le fichier personnages permet de consigner tous les personnages du film. Grâce à cette consignation, des brins et des statistiques automatiques peuvent être générées à l'[extraction des données].

Le nom de ce fichier doit être impérativement : `persos.simple_collecte`.

### Créer le fichier personnages {#create_file_persos}

La commande de bundle `Personnage : Créer fichier` permet de crérer le fichier.

Il suffit donc d'ouvrir le dossier du projet dans TextMate si ça n'est pas fait, d'afficher un de ses fichiers, puis d'activer cette commande.

Il suffit ensuite de [définir les personnages] en suivant la procédure décrite.

<!--
    C R É A T I O N   D ' U N   P E R S O N N A G E
-->

### Définir les personnages {#create_personnage}

Pour créer un personnage dans le [fichier des personnages], il suffit de taper `perso[TAB]` à l'endroit voulu, en général à la fin du fichier. Utiliser ensuite la touche tabulation pour passer d'une rubrique à l'autre et les renseigner.


<!--

    E X T R A C T I O N   D E S   D O N N É E S

-->

## Extraire les données {#extraction_data}

Pour extraire les données, il suffit de se rendre dans la partie “Dépôt” des analyses de la boite à outils de l'auteur : <a href="#" onclick="open_url('http://localhost/WriterToolbox/analyse_build/depot')">version OFFLINE</a> (<a href="#" onclick="open_url('http://www.laboiteaoutilsdelauteur.fr/analyse_build/depot')">version ONLINE</a>) et de soumettre les fichiers de simple collecte.

### Emplacement des données extraites {#emplacement_extraction}

Pour le moment, les données extraites se trouve dans le dossier `tmp/analyse/<ID user>/<ID film>/` de la boite à outils de l'auteur.

### Données extraites {#data_extraites}

Par défaut, le parse des fichiers de collecte produira deux fichiers très intéressants :

* le fichier `scenes.html` qui contient la liste des scènes sous forme d'évènemencier/chemin de fer ;
* le fichier `brins.html` qui contient la liste des brins, avec l'indication de la position des scènes.

D'autres formats sont également disponible en utilisant la page d'extraction des données. On peut notamment n'extraire qu'une partie seulement du film.

## Annexes {#annexes}

### Divisions temporelles {#divisions_temporelles}

On peut obtenir les divisions temporelles du film, c'est-à-dire la position des quarts, des tiers, etc., en utilisant la commande `Divisions`. Cette commande crée le fichier `divisions.txt` qui contient tous les temps.

On peut également utiliser le raccourci `CMD + D` (« D » comme Divisions). Ajouter la touche `MAJ` pour forcer l'actualisation de ce fichier (`CDM + MAJ + D`).

> Ces temps sont exprimés d'abord par rapport aux temps de la collecte, puis par rapport aux temps réels du film (entendu que le film ne commence pas au temps `0:00:00`).

Pour actualiser ce fichier, si des temps sont modifiés, il suffit de détruire le fichier `divisions.txt` dans le [dossier de collecte].

On peut également utiliser `CMD + MAJ + D` pour forcer cette actualisation.
