# Timeline

La « Timeline » ou « Ligne de temps » permet de visualiser les éléments sur une ligne de temps représentant l'intégralité du film.

## Scènes sur la timeline {#scenesontimeline}

Ce qu'il faut comprendre avec les scènes sur la timeline, c'est qu'elles ne s'y trouvent pas, en vérité. Elles se trouvent dans leur bloc, mais grâce à leur `position:fixed` on donne l'impression qu'elles sont dans la timeline.

Pourquoi ? Simplement pour pouvoir les faire apparaitre simplement avec `CSS` en glissant la souris dessus. Lorsqu'on glisse la souris sur la scène (son affichage dans le document), on change la couleur de fond de la scène sur la timeline.
