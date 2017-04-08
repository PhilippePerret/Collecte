# encoding: UTF-8
class Film
class Scene
class << self

  # {String template}
  # Utiliser la méthode `build_template_intitule` pour
  # définir l'intitulé.
  attr_reader :template_intitule

  def build_template_intitule options
    tempint =
      if options.key?(:intitule)
        options[:intitule]
      else
        props = [:horloge, :numero, :lieu, :decor, :effet]
        props.reject!{|prop| options["no_#{prop}".to_sym] == true}
        props.collect{|prop| "%{#{prop}}"}.join('')
      end
    # Pour le moment, tempint ressemble à :
    #   %{horloge} %{effet} etc.
    # Si le format est HTML, il faut le transformer en
    #   <span class="horloge">%{horloge}</span><span class="effet"> etc.
    if options[:format] == :html
      tempint.gsub!(/\%\{([a-z]+)\}/){
        prop = $1
        span("%{#{prop}}", class: prop)
      }
    end
    @template_intitule = div(tempint, {class:'intitule'})
  end

end #/<< self
end #/Scene
end #/Film
