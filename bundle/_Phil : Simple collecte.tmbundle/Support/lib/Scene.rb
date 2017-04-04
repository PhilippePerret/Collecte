require_relative 'direct'
class Scene
  class << self
    
    #---------------------------------------------------------------------
    #   Pour Snippets
    #---------------------------------------------------------------------

    # => Return Snippet pour la fonction-clé seule
    def keyfonction_snippet
      "KEYFONCTION: ${#{Snippet::next_tab}|#{keyfonctions_as_snippet_list.join(',')}|}"
    end
  
    # => Return code du Snippet pour une scène normale
    def scene_snippet with_keyfonction = false
      ajout_kf = ""
      ajout_kf = "\n\t#{keyfonction_snippet}" if with_keyfonction
      <<-COD
SCENE:#{Snippet::horloge nil, false}#{ajout_kf}
  RESUME:   ${#{Snippet::next_tab}:Résumé}
  FONCTION: ${#{Snippet::next_tab}:Fonction de la scène}
  SYNOPSIS: ${#{Snippet::next_tab}:Synopsis}
      COD
    end
    # => Returne Snippet pour une scène-clé
    def keyscene_snippet
      scene_snippet true
    end
  
    #---------------------------------------------------------------------
    #   Utilitaires
    #---------------------------------------------------------------------
    # Liste des fonctions clés pour le snippet
    def keyfonctions_as_snippet_list
      @keyfonctions_as_snippet_list ||= keyfonctions.collect { |k,v| k }
    end
  
    # Données des fonctions clés
    def keyfonctions
      @keyfonctions ||= begin
        require File.join(FilmTM::folder_data, 'keyfonctions.rb')
        KEYFONCTION_STRING_TO_ID
      end
    end
  end  
end