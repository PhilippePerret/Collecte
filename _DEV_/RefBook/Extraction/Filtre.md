# Filtre

Le filtre permet de ne filtrer que certains éléments de la collecte.

On définit le filtre grâce à la propriété `:filter` dans les options :

~~~
  coll = Collecte.new('mon/dossier/collecte')
  coll.parse # si nécessaire
  coll.extract(
    as: :sequencier,
    filter: {
      brins: '2+4'
      }
    )
~~~

### Définition du filtre {#definition_du_filtre}

Les filtres fonctionnent en définissant un `String` composé de `+` (brin requis), `,` (brin alternatif) et `()`.

Exemple :

~~~
  options = {
    filter: {
      brins: <valeur du filtre>
    }
  }
~~~


~~~
  Valeur du filtre

  2,45    Toutes les scènes des brins 2 OU 45
          sont conservées (la virgule est OU).

  2+45    Les scènes doivent appartenir aux brins
          2 ET au brin 45.

  (2,45)+12

          Signifie que les scènes doivent appartenir
          au brin 2 OU au brin 45 (mais obligatoirement
          à au moins 1) ET toujours au brin 12.
~~~
