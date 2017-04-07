# encoding: UTF-8
#
# Méthodes utiles quand l'option :full_file est true (par
# défaut) et qu'il faut donc produire un fichier HTML
# complet.
#
class Collecte
class Extractor
class FinalFile

  # Méthode qui permet de produire le code pour charger une feuille de styles
  # qui se trouve dans le dossier lib/css du dossier analyse.
  # Ce code CSS est "accroché" au document produit.
  def balise_styles affixe_file
    '<style type="text/css">' +
      File.read(css_file)     +
    '</style>'
  end

end #/FinalFile
end #/Extractor
end #/Collecte
