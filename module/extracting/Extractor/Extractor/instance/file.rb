# encoding: UTF-8
class Collecte
class Extractor

  # Prépare le fichier en vue de l'extraction
  #
  # Construit le dossier `extraction` s'il n'existe pas
  #
  # Retourne true pour dire de continuer
  def prepare_file
    File.exist?(folder) || Dir.mkdir(folder, 0755)
    @file_content = String.new
    File.exist?(path) && File.unlink(path)
    File.open(path,'wb'){|f| f.write code_depart}
    return true
  end

  # Enregistre dans le fichier d'extraction les
  # données déjà extraites et remet le @file_content
  # à rien
  def flush_file_content
    file_content != '' || return
    File.open(path,'a'){|f| f.write @file_content}
    @file_content = ''
  end

  # Le code de départ du fichier en fonction du
  # format de sortie.
  def code_depart
    date = Time.now.strftime("%d %m %Y - %H:%M")
    case format
    when :html
      <<-HTML
<!--
  EXTRACTION DU #{date}
  FILM : #{collecte.film.id}
-->
      HTML
    when :text
      <<-TEXT
#
# Extraction de #{date}
# ================================
# Film : #{collecte.film.id}
#

      TEXT
    when :xml
    end
  end
end #/Extractor
end #/Collect
