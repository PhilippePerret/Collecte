# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  # Préparation du fichier
  def prepare
    log "  -> prepare [path=#{path.inspect}]"
    File.exist?(folder) || Dir.mkdir(folder, 0755)
    @file_content = String.new
    File.exist?(path) && File.unlink(path)
    File.open(path,'wb'){|f| f.write code_depart}
    log "  <- prepare"
    return true # pour dire de continuer
  end

  # Finalisation du fichier
  # Cette méthode sert juste pour les formats :XML et
  # :TEXT qui pour le moment ne font rien d'autre. Pour
  # :HTML, une méthode propre permet de finaliser complètement
  # le fichier HTML.
  def finalise
    return true # pour dire de continuer
  end

end #/FinalFile
end #/Extractor
end #/Collecte
