# encoding: UTF-8
#
# Méthodes utiles quand l'option :full_file est true (par
# défaut) et qu'il faut donc produire un fichier HTML
# complet.
#
# La plupart de ces méthodes sont appelées par le gabarit
# ERB se trouvant à la racine.
#
class Collecte
class Extractor
class FinalFile

  def code_depart
    <<-HTML
<!--
EXTRACTION DU #{collecte.extractor.date}
FILM : #{collecte.film.id}
-->
    HTML
  end

  # Finalisation du fichier
  def finalise
    # Pour construire le code final.
    # Il faut le faire ici, avant le File.open, car
    # c'est dans le même fichier que le code est
    # assemblé (au cours de l'extraction) puis il est
    # finalisé ici et copié dans le même fichier.
    file_full_code
    # On écrit finalement le code assemblé dans le fichier
    # final.
    File.open(path,'wb'){ |f| f.write file_full_code }
    return true # pour dire de continuer
  end


  # Code complet à copier dans le fichier
  def file_full_code
    @file_full_code ||= begin
      require 'erb'
      ERB.new(gabarit_code).result(self.bind)
    end
  end

  def gabarit_code
    File.read( _('gabarit.erb', __FILE__) )
  end

  def bind; binding() end

  def title= value ; @title = value end
  def title
    @title ||= begin
      "Extraction des données du #{collecte.extractor.date}"
    end
  end

  def bandeau_superieur
    ''
  end

  # Le contenu complet, sous le bandeau supérieur
  # Ce contenu se trouve dans le fichier final provisoire
  def full_content
    File.read(path)
  end

  def whole_javascript_code
    '<!-- SCRIPTS JAVASCRIPT -->'
  end

end #/FinalFile
end #/Extractor
end #/Collecte
