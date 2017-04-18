# encoding: UTF-8
class Film
class Decor

  LETTER_LIEU_TO_LIEU = {
    'I' => 'INT.', 'E' => 'EXT.', 'N' => 'NOIR'
  }

  def lieu_as_str
    @lieu_as_str ||= LETTER_LIEU_TO_LIEU[lieu]
  end

end #/Decor
end #/Film
