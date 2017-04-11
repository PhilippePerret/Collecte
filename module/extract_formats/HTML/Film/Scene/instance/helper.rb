# encoding: UTF-8
class Film
class Scene

  # Raccourci
  def options ; @options ||= self.class.options_extraction end

  # Code HTML pour l'affichage de la scène dans un
  # séquencier.
  def as_sequence
    div(
      intitule_html +
      resume_html +
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
  def intitule_html
    self.class.template_intitule % {horloge: horloge.real_horloge, numero: numero, lieu: lieux, effet: effets, decor: decors}
  end
  def resume_html
    div(resume.to_html, class: 'resume')
  end

  # ---------------------------------------------------------------------
  #   Sous-sous-méthodes
  # ---------------------------------------------------------------------
  def lieux
    lieu_alt || (return lieu)
    "#{lieu} / #{lieu_alt}"
  end
  def effets
    effet_alt || (return effet)
    "#{effet} / #{effet_alt}"
  end
  def decors
    decor_alt || (return decor)
    "#{decor} / #{decor_alt}"
  end

end #/Scene
end #/Film
