require_relative 'direct'
class Info
  
  class << self
    
    # Retourne la liste des types d'information
    def type_list
      @type_list ||= begin
        require File.join(FilmTM::folder_data, 'types_infos')
        ITYPES_INFOS.keys
      end
    end
  end
end # class Info
