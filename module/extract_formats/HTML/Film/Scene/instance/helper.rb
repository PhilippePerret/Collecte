# encoding: UTF-8
class Film
class Scene

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

  def bloc_timeline
    div('', {class:'btm', id: "tl-sc-#{id}", style: "left:#{horloge.left}px;width:#{horloge.width}px;"})
  end

  # ---------------------------------------------------------------------
  #   Sous-méthodes
  # ---------------------------------------------------------------------
  def intitule_html
    self.class.template_intitule % {horloge: horloge.horloge, numero: numero, lieu: lieux, effet: effets, decor: decors}
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
