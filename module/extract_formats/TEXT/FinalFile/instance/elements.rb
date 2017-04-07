# encoding: UTF-8
#
# Méthodes utiles quand l'option :full_file est true (par
# défaut) et qu'il faut donc produire un fichier HTML
# complet.
#
class Collecte
class Extractor
class FinalFile

  def code_depart
    <<-TEXT
#
# Extraction de #{collecte.extractor.date}
# ================================
# Film : #{collecte.film.id}
#

    TEXT
  end

end #/FinalFile
end #/Extractor
end #/Collecte
