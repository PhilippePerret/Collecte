# encoding: UTF-8
class Collecte
class Extractor

  # Pour initialiser l'extracteur lorsque plusieurs fichiers
  # sont demandés en sortie, par exemple lorsque l'argument
  # :all_brins est utilisé.
  def init
    @scenes     = nil
    @from_time  = nil
    @to_time    = nil
    @final_file = nil
    @format     = nil
  end

end #/Extractor
end #/Collect
