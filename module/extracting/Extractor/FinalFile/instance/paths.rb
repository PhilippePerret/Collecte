# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  # Défini dans le fichier `set_by_type.rb`
  attr_accessor :faffixe

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
