require_relative 'direct'
require File.join(FilmTM::folder_data, 'keyfonctions') # => KEYFONCTION_STRING_TO_ID
class Structure  
  class << self
    
    # Retourne les keyfonctions humaine comme une liste (pour commande/snippet)
    # @usage: Structure::keyfonction_list
    def keyfonction_list
      @keyfonction_list ||= KEYFONCTION_STRING_TO_ID.collect{|khuman,symbole| khuman}
    end
  end
end # class Structure

