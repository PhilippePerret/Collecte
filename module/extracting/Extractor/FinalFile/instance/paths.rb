# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  def fextension
    case format
    when :html  then 'html'
    when :text  then 'txt'
    when :xml   then 'xml'
    end
  end

  def fname
    @name ||= begin
      case (options||{})[:as]
      when :sequencier
        # TODO Tenir compte des valeurs :from_time, :to_time
        "sequencier.#{fextension}"
      when :brin
        "brin_#{options[:filter][:brins].gsub(/[\(\),\+]/,'_').gsub(/ /,'')}.#{fextension}"
      else
        "extract_data.#{fextension}"
      end
    end
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
