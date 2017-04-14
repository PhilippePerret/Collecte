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
      prop = line[0..offsetdp-1].strip
      valu = line[offsetdp+1..-1].nil_if_empty
      valu != nil || next

      if prop.start_with?('STT_')
        #
        # => Donnée de structure
        #
        prop = prop[4..-1].downcase.nil_if_empty
        prop != nil || next
        prop = prop.to_sym # p.e. :climax ou :

        if film.structure[prop].nil?
          raise "La donnée structure `#{prop.inspect}` est inconnue. Les métadonnées sont mal définies."
        else
          film.structure[prop][:horloge] = Film::Horloge.new(film, valu)
        end
      else
        prop = prop.downcase.to_sym

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
    end
    return true # parsing ok
  end

end #/Metadata
end #/Collecte
