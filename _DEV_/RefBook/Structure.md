# Structure

On parle dans Collecte de `points structurels` pour parler des points qui définissent la structure du film.

Dans `Collecte`, ce sont des éléments de classe `Film::Structure::Point`.

Chaque scène — en fait : chaque objet relatif — peut contenir dans sa propriété `:stt_points_ids` la liste des identifiants de points structurels. Par exemple :

~~~
      @stt_points_ids = [:inc_pert, :inc_dec, :pivot_1]
~~~

Ces appartenances sont définies au parsing lorsque la scène contient des marques :

~~~
      STT_<definition point>
~~~

Par exemple :

~~~
      1:23:12 INT. JOUR MAISON DE JOE
      [PERSO#joe] rentre chez lui.
      STT_INC_DEC
~~~

Cette scène est définie comme l'incident déclencheur du film.
