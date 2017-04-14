# encoding: UTF-8
class Film
class Brin

  # Dispatcher les données du brin
  alias :top_dispatch :dispatch
  def dispatch hdata
    top_dispatch hdata
    @libelle      = Film::TextObjet.new(film).dispatch(@libelle)
    @description  = Film::TextObjet.new(film).dispatch(@description)
  end

end #/Brin
end #/Film
