# Classe `Film::Structure::Point`

Gère les « points structurels » définis par le paradigme de Field augmenté, c'est-à-dire :

* l'incident perturbateur,
* l'incident déclencheur,
* le pivot 1,
* le début du développement,
* la clé de voûte,
* le début de la seconde partie de développement,
* la crise,
* le pivot 2,
* le dénouement,
* le climax

On peut voir aussi :

* La zone de refus : calculée entre l'incident déclencheur et le pivot 1.

## Coup d'œil rapide

Les méthodes importantes d'un point structurel sont :

~~~
      exist?      True si le point est défini dans le film
                  (dans la collecte des scènes)

      in_zone?    Pour savoir si le point est dans sa zone
      out_zone?   absolue (modèle de Field) ou en dehors.
                  Les deux méthodes (ainsi que `offset`)
                  retournent NIL s'il s'agit d'un point qui
                  n'est pas fixé dans le temps, comme la
                  crise par exemple.

      offset      Si le point est hors zone, le décalage avec
                  la zone absolue.
                  < 0 si le point est avant la zone absolue
                  > 0 si le point est après la zone absolue
                  C'est un nombre de secondes.

      zone_pfa    Pour avoir la zone absolue, avec
                  `zone_pfa.debut` qui donne le début en secondes
                  et `zone_pfa.fin` qui donne la fin en secondes.
                  C'est une instance {Film::Zone}.

      zone_pfa_h  La marque "de h:mm:ss à h:mm:ss" pour spécifier
                  la zone.
      zone_relative_h Idem, pour la zone relative, donc celle du
                  film (= la scène)

~~~

## Rapport statistique

Ces données du film servent notamment pour le fichier statistique qui indiquera les écarts entre les positions absolues (celle du modèle de Field) et les positions relatives (celles définies dans le film).

## Graphique

À l'avenir, ces données serviront aussi à dessiner les deux positions (absolue et relative) dans deux graphiques superposés, comme dans les analyses TM.

## Instanciation

Un `point structurel` s'instancie simplement avec :

* l'`owner`, le propriétaire du point structurel (pour le moment, une scène),
* son identifiant (dans `Film::Structure::Point::ABS_POINTS_DATA`), par exemple `:inc_dec` ou `:climax`.

Le `owner` doit répondre aux méthodes :

~~~
      film        {Film} Film du propriétaire
      horloge     {Film::Horloge} Une horloge qui permet de
                  récupérer le début et la fin.
~~~

## Propriétés

Les propriétés d'un `point strcturel` sont :

~~~
      zone_pfa    {Film::Zone} Zone qui détermine une zone sur
                  le PFA (modèle de Field).
                  Répond notamment à `start`, `end`, `in_zone?`
                  etc.
~~~

## Méthodes

~~~
      defined?    Retourne true si le point structurel est
                  défini dans le film courant.

      in_zone?    Si la +zone_pfa+ est définie, cette méthode
                  retourne true si le point structurel se trouve
                  sur la zone du modèle de Field.
                  Retourne false dans le cas contraire.

      out_zone?   Inverse de la précédente.

      offset      {Fixnum de secondes} Décalage avec la position
                  absolue.
                  0 si le point est in_zone?
                  Un nombre POSITIF lorsque la position relative
                  est APRÈS la position absolue.
                  Un nombre NÉGATIF lorsque la position relative
                  est AVANT la position absolue.
~~~
