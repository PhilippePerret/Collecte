# encoding: UTF-8
class Film
class RelationPersonnage

  def human_personnage_list
    @human_personnage_list ||= begin
      personnages.collect{|perso| perso.pseudo}.pretty_join
    end
  end

  def to_str
    @to_str ||= "Relation entre #{human_personnage_list}"
  end
  
end #/RelationPersonnage
end #/Film
