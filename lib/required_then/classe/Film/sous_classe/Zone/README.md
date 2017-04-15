# Classe `Film::Zone`

Pour définir une zone de temps.

Les propriétés principales sont :

~~~
      name      {String} Le nom de la zone.

      debut     {Fixnum} Nombre de secondes du début de la
                zone.
      fin       {Fixnum} Nombre de secondes de fin de la zone

      position  {Fixnum} La position exacte, sans tolérance

~~~


## Méthodes

~~~

      in_zone?(zone)  
          Retourne true si la zone se trouve dans la zone +zone+
          fournie.
          Une zone est dans une autre lorsqu'elle commence ou
          finit entre le début et sa fin de la zone.

      out_zone?(zone)
          Retourne true si la zone se trouve en dehors de la
          zone +zone+ fournie.
          Une zone est en dehors d'une autre lorsqu'elle termine
          avant ou commence après.
~~~

## Instanciation

Pour l'instanciation, `Film::Zone` attend un `Hash` de données contenant :

~~~
      position  {Fixnum} La valeur de départ
      OU
      coefpos   {Float} Le coefficiant de position, par rapport
                à +duree_totale+. Par exemple, le début du
                développement à un coefpos à 0.25, ce qui signifie
                qu'il commence à un quart.
      OU
      coef_after  {Float} Ces deux flottants permettent de définir
      coef_before le point avant et/ou le point après. Par exemple,
                  l'incident déclencheur doit se trouver avant
                  le début du développement donc il est défini par
                  coef_before: 0.25. Le climax, lui, doit se
                  trouver dans le dénouement, donc il est défini
                  par coef_after: 0.75 (en fait, la valeur exacte
                  est 0.75 + 1.0/24)
                  Ces deux valeurs s'emploient sans tolérance. Si
                  une tolérance est définie, elle ne sera pas
                  considérée.

      duree_totale  {Fixnum} La durée, si coefpos est utilisé,
                pour pouvoir calculer debut, fin, etc.

      tolerance {Fixnum} La tolerance en nombre de secondes,
                permet de définir le start et le end suivant
                la formule : start = position - tolerance / 2

      name      {String} Le nom humain de la zone, par
                exemple "Zone de Climax"
~~~
