# encoding: UTF-8
class Film
class Personnage

  # Méthode pour parser un bloc de définition
  # de personnage
  def parse bloc
    # Un bloc pour un personnage est composé de lignes avec
    #   propriété: valeur
    # La première propriété, "personnage", est l'identifiant
    bloc.split(RC).each do |line|
      offset = line.index(':')
      offset.to_i > 0 || next
      prop  = line[0..offset-1].downcase.nil_if_empty
      prop != 'personnage' || prop = 'id'
      val   = line[offset+1..-1].nil_if_empty
      # Même si la valeur est nil, on l'affecte, ça ne mange
      # pas de pain.
      instance_variable_set("@#{prop}", val)
    end
  end

end #/Personnage
end #/Film
