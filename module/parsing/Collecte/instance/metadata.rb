# encoding: UTF-8
class Collecte
class Metadata

  # Méthode pour parser le fichier metadata.collecte
  def parse
    parse_file || return
    log "Métadata parsées (#{data.inspect})"
  end

  # Méthode qui récupère les valeurs dans le fichier
  def parse_file
    exist? || (return false)
    @data = Hash.new
    File.read(path).split(RC).each do |line|
      line = line.strip
      !line.start_with?('#') || next
      offsetdp = line.index(':').to_i
      offsetdp > 0 || next
      prop = line[0..offsetdp-1].downcase.to_sym
      valu = line[offsetdp+1..-1].nil_if_empty
      # Modification de quelques noms de propriété
      prop =
        case prop
        when :auteurs_collecte  then :auteurs
        when :debut_collecte    then :debut
        when :fin_collecte      then :fin
        else prop
        end
      # Modification de quelques valeurs
      valu =
        case prop
        when :auteurs
          valu.split(',').collect{|n| n.strip}
        else valu
        end
      @data.merge! prop => valu
    end
    return true # parsing ok
  end

end #/Metadata
end #/Collecte
