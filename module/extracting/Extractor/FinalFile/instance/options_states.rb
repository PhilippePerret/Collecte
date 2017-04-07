# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  # Les options transmises pour procéder à l'extraction
  attr_accessor :options

  def full_file?
    @is_full_file ||= options[:full_file] == true
  end


end #/FinalFile
end #/Extractor
end #/Collecte
