# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  def faffixe
    @faffixe ||= begin
      case (options||{})[:as]
      when :sequencier
        af = "sequencier"
        options[:suggest_structure] && af << "_suggest_stt"
        if options[:from_time] || options[:to_time]
          af = add_from_to_to_affixe(af)
        else
          af = "full_#{af}"
        end
        af
      when :brin
        af = "brin_#{options[:filter][:brins].gsub(/[\(\),\+]/,'_').gsub(/ /,'')}"
        add_from_to_to_affixe(af)
      else
        add_from_to_to_affixe('extract_data')
      end
    end
  end

  def add_from_to_to_affixe aff
    options[:from_time] && aff << "_from_#{options[:from_time]}"
    options[:to_time]   && aff << "_to_#{options[:to_time]}"
    return aff
  end

  def fextension
    case format
    when :html  then 'html'
    when :text  then 'txt'
    when :xml   then 'xml'
    end
  end

  def fname
    @name ||= "#{faffixe}.#{fextension}"
  end

  def path
    @path ||= File.join(folder, fname)
  end

  def folder
    @folder ||= File.join(collecte.folder,'extraction')
  end

end #/FinalFile
end #/Extractor
end #/Collecte
