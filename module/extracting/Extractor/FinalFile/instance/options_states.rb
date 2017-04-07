# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  # Les options transmises pour procéder à l'extraction
  attr_accessor :options

  def full_file?
    @is_full_file ||= options[:full_file] == true
  end

  def whole?
    @whole_data ||= options[:as] == :whole
  end
  def sequencier?
    @as_sequencier ||= options[:as] == :sequencier
  end
  alias :outline? :sequencier?


end #/FinalFile
end #/Extractor
end #/Collecte
