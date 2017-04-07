# encoding: UTF-8
class Film
class Scene

  # Code HTML pour l'affichage de la scène dans un
  # séquencier.
  def as_sequence
    div(
      intitule_html +
      resume_html,
      {class: 'scene', id: "scene-#{id}"}
    )
  end

  # ---------------------------------------------------------------------
  #   Sous-méthodes
  # ---------------------------------------------------------------------
  def intitule_html
    div(
      span(horloge.horloge, class: 'horloge') +
      span(lieux,  class: 'lieu') +
      span(effets, class: 'effet') +
      span(decors, class: 'decor'),
      {class: 'intitule'}
    )
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
