# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  # {Collecte} Instance de la collecte du fichier
  attr_reader :collecte

  # {String} Contenu à flusher dans le fichier
  # Noter qu'il ne contient jamais tout le code, mais
  # seulement une partie courante (par exemple seulement
  # les brins s'ils sont en train d'être traités)
  attr_reader :file_content

  def format ; @format ||= options[:format] end

  # {Symbol} Type du fichier
  def type ; @type ||= options[:type] end

  # Raccourcis
  def options ; @options  ||= collecte.extractor.options  end
  def film    ; @film     ||= collecte.film               end

  # Le titre final, en fonction du type
  def titre_final
    @main_titre ||= begin
      case options[:as]
      when :sequencier
        tit = "Séquencier"
        options.key?(:filter) || tit << " complet"
        tit
      when :brin
        "Brin #{options[:filter][:brins].gsub(/[\(\),\+]/,' ')}"
      else
        "Données complètes"
      end + " du film “#{film.titre}”"
    end
  end

end #/FinalFile
end #/Extractor
end #/Collecte
