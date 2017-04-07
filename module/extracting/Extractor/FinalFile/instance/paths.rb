# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  def extension
    case format
    when :html  then 'html'
    when :text  then 'txt'
    when :xml   then 'xml'
    end
  end

  def path
    @path ||= File.join(folder, "extract_data.#{extension}")
  end

  def folder
    @folder ||= File.join(collecte.folder,'extraction')
  end

end #/FinalFile
end #/Extractor
end #/Collecte
