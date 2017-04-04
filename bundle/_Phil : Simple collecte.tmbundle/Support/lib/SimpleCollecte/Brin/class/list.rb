# encoding: UTF-8
class SimpleCollecte
class Brin
class << self
  
  # Écrit en sortie le snippet pour choisir un brin
  def print_snippet_list
    STDOUT.write snippet_list
  end
  # Retourne le snippet pour choisir un brin dans la 
  # liste des brins
  def snippet_list
    choix = UI.choose_from_list(brins_as_list_items)
    choix = choix.split('-').first
    "b#{choix}"
  end
  
  # Liste des brins, pour choix
  def brins_as_list_items
    @brins_as_list_items ||= brins.collect{|b|b.for_snippet}
  end
  # Retourne la liste des brins
  # Array d'instance SimpleCollecte::Brin
  def brins
    @brins ||= begin
      code_brins.scan(/^([0-9]+)#{RC}(.*?)#{RC}/m).to_a.collect do |found|
        new({id: found[0].to_i, libelle: found[1].strip})
      end
    end
  end
  
  def code_brins
    @code_brins ||= begin
      File.exist?(file_path) || raise('Aucun fichier brins n’est défini.')
      File.read(file_path)
    end
  end
  
  def file_path
    @file_path ||= File.join(Film.folder, 'brins.simple_collecte')
  end

end #/<< self
end #/Brin
end #/SimpleCollecte