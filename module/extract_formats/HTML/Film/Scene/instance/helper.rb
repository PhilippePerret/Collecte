# encoding: UTF-8
class Film
class Scene

  class << self

    # {String template}
    # Utiliser la méthode `build_template_intitule` pour
    # définir l'intitulé.
    attr_reader :template_intitule

    def build_template_intitule options
      int = String.new
      [
        :horloge, :numero, :lieu, :decor, :effet
      ].each do |prop|
        methno = "no_#{prop}".to_sym
        options[methno] || int << span("%{#{prop}}", class: prop.to_s)
      end
      @template_intitule = div(int, {class:'intitule'})
    end

  end #/<< self

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
