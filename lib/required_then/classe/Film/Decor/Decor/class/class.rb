# encoding: UTF-8
class Film
class Decor
class << self

  # Pour obtenir un nouvel identifiant pour un brin
  def new_id
    @last_id ||= 0
    @last_id += 1
  end

end #/<< self
end #/Decor
end #/Film
