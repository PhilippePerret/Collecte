# encoding: UTF-8
class Film
class Scene

  # Raccourci
  def options ; @options ||= self.class.options_extraction end

  # Code HTML pour l'affichage de la scène dans un
  # séquencier.
  def as_sequence
    div(
      showinTM_link +
      intitule_html +
      resume_html +
      bloc_timeline,
      {class: 'scene', id: "scene-#{id}"}
    )
  end

  # Code HTML pour l'affichage de la scène dans un
  # brin.
  # C'est en fait une séquence (`as_sequence`) mais les paragraphes
  # du brin en question doivent être affichés.
  def as_brin
    # La liste des paragraphes dans le brin (si un brin est
    # demandé) a pu être calculée précédemment, quand tous les
    # brins sont demandés. Donc il faut initiliser la variable
    # ici pour la recalculer pour le brin courant
    @paragraphes_in_brins = nil
    nombre_paragraphes_in_brins = paragraphes_in_brins.count
    # Le résumé doit être écrit chaque fois SAUF :
    #   - si l'option :no_resume_when_paragraphes est true
    #   - et que la scène contient des paragraphes qui répondent
    #     au filtre
    final_resume =
      if nombre_paragraphes_in_brins > 0 && options[:no_resume_when_paragraphes]
        brins_paragraphes_html # note : pas de div.paragraphes
      else
        resume_html + brins_paragraphes_html
      end
    div(
      showinTM_link +
      intitule_html +
      final_resume +
      bloc_timeline,
      {class: 'scene', id: "scene-#{id}"}
    )
  end

  # Code HTML pour l'affichage de la scène sous
  # forme de synopsis. L'horloge, en fonction des options,
  # peut être marquée dans la marge gauche.
  #
  def as_synopsis
    horloge_synopsis +
      # On met l'horloge en dehors du div de scène pour
      # qu'elle soit dans la marge gauche.
    div(
      resume_synopsis,
      {class: 'scene', id: "scene-#{id}"}
    )
  end
  def horloge_synopsis
    if options[:horloge]
      span(horloge.real_horloge, {class: 'horloge'})
    else
      ''
    end
  end
  def resume_synopsis
    if paragraphes.empty?
      resume_html
    else
      paragraphes.collect do |paragraphe|
        paragraphe.to_html
      end.join(' ')
    end
  end

  # Le bloc pour visualiser la scène sur la Timeline.
  # Cf. le fichier RefBook > Timeline.md pour bien comprendre
  # le fonctionnement (ce bloc, en vérité, n'est pas dans la
  # Timeline)
  def bloc_timeline
    if options[:no_timeline]
      ''
    else
      div('', {class:'btm', id: "tl-sc-#{id}", style: "left:#{horloge.left}px;width:#{horloge.width}px;"})
    end
  end

  # ---------------------------------------------------------------------
  #   Sous-méthodes
  # ---------------------------------------------------------------------

  # Retourne le code HTML de la liste des paragraphes
  # qui appartiennent au brin en construction.
  # Notes
  #   * Il peut s'agir de brins multiples.
  #   * La méthode n'est appelée que si la scène appartient
  #     au brin, MAIS peut-être que seul le résumé appartient
  #     au brin, donc aucun paragraphes ne peuvent correspondre
  def brins_paragraphes_html
    str =
      paragraphes_in_brins.collect do |hparag|
        div(hparag[:content], {class: 'paragraphe', id: "paragraphe-#{hparag[:index]}"})
      end.join('')
    # on met les paragraphes dans un div.paragraphes s'il y
    # en a (même lorsque le résumé de la scène ne doit pas
    # être affiché)
    if str == '' || options[:no_resume_when_paragraphes]
      str
    else
      '<div class="paragraphes">'+str+'</div>'
    end
  end
  # Retourne un Array de TextObjet qui sont les paragraphes
  # répondant au filtre des brins définis
  # NOTE : @paragraphes_in_brins doit être réinitialisé
  # à chaque sortie (cf. méthode `as_brin` plus haut)
  def paragraphes_in_brins
    @paragraphes_in_brins ||= begin
      parsok = Array.new
      paragraphes.each_with_index do |parag, ipar|
        if (parag.brins_ids||[]).passe_filtre?(options[:filter][:brins])
          parsok << {content: parag.to_html, index: (ipar+1)}
        end
      end
      parsok
    end
  end

  def intitule_html
    self.class.template_intitule % {horloge: horloge.real_horloge, numero: numero, lieu: lieux, effet: effets, decor: decors}
  end
  def resume_html
    div(resume.to_html, class: 'resume')
  end

  # ---------------------------------------------------------------------
  #   Sous-sous-méthodes
  # ---------------------------------------------------------------------
  def effets
    effet_alt || (return effet)
    "#{effet} / #{effet_alt}"
  end
  def lieux
    decors_ids.collect do |decor_id|
      film.decors[decor_id].lieu_as_str
    end.join(' / ')
  end
  def decors
    decors_ids.collect do |decor_id|
      film.decors[decor_id].decor
    end.join(' / ')
  end

end #/Scene
end #/Film
