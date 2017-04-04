require_relative 'direct'
require_relative 'Personnage'
class Brin
    
  class << self
    
    #---------------------------------------------------------------------
    #   Snippets
    #---------------------------------------------------------------------
    
    # => Code Snippet pour un nouveau brin
    def snippet_nouveau
      <<-SNIPPET
BRIN:${#{Snippet::next_tab}:IDENTIFIANT MNEMO}
  TITRE: ${#{Snippet::next_tab}:TITRE DU BRIN}
  BTYPE: ${#{Snippet::next_tab}|#{list_types_brins.join(',')}|}
  DESCRIPTION: ${#{Snippet::next_tab}:DESCRIPTION DU BRIN}
$0
      SNIPPET
    end
    
    # => Code Snippet pour choisir un brin du film
    def snippet_choose_brin
      "[BRIN#${#{Snippet::next_tab}|#{snippetlist}|}]$0"
    end
    
    # => Code Snippet pour une key-fonction de brin
    def snippet_keyfonction_brin
      "KEYFONCTION#${#{Snippet::next_tab}|#{list.join(',')}|}: "+
      "[${#{Snippet::next_tab}|#{Structure::keyfonction_list.join(',')}|}] "+
      "${#{Snippet::next_tab}:Raison}"+
      "$0"
    end
    
    # => Code Snippet pour définir la raison de l'appartenance à un brin
    def snippet_raison_appartenance_brin
      "BRIN#${#{Snippet::next_tab}|#{list.join(',')}|}: ${#{Snippet::next_tab}:Raison appartenance}$0"  
    end
    
    #---------------------------------------------------------------------
    #   Utilitaire
    #---------------------------------------------------------------------
    
    # ---------------------------------------------------------------------
    #   Données absolues
    # ---------------------------------------------------------------------
    # Retourne les btypes des brins (données absolues) comme une liste pour snippet
    def list_types_brins
      @list_types_brins ||= data_types.keys
    end
    
    # => Données des types de brins (données absolues)
    def data_types
      @data_types ||= begin
        require File.join(FilmTM::folder_data, 'types_brins')
        BTYPES_BRINS
      end
    end
    
    # ---------------------------------------------------------------------
    #   Données propres au film
    # ---------------------------------------------------------------------
    
    # Création ou actualisation des données des brins du film
    # => Doit retourner les données des brins
    def update_data_brins_film
      File.unlink path_data if File.exists? path_data # update
      @data = {:list_ids => []}
      if File.exists? path
        File.read(path).gsub(/^BRIN\:(.+)$/){
          brin_id = $1
          @data[:list_ids] << brin_id
        }
        Personnage::list_ids.each do |perso_id|
          @data[:list_ids] << perso_id
        end
        File.open(path_data, 'wb'){|f| Marshal.dump(@data, f)}
      end
      return @data
    end
    
    # => Return true si le film a des brins
    def has_brins?
      list.count > 0
    end
    
    # => Return String pour snippet de la liste des brins
    def snippetlist
      list.join(',')
    end
    
    # Retourne la liste des identifiants de brins du film courant
    def list
      data[:list_ids]
    end
    
    # Retourne les données brins enregistrés dans le fichier Marshal (ou nil)
    # @note: Il s'agit des brins du film courant
    def data
      @data ||= begin
        if data_brins_film_ok?
          File.open(path_data, 'r'){ |f| Marshal.load(f) } 
        else
          update_data_brins_film
        end
      end
    end
    # => True si le fichier des données des brins du film existe et est
    # à jour.
    def data_brins_film_ok?
      (File.exists? path ) && (File.exists? path_data ) &&
      (File.stat(path_data).mtime > File.stat(path).mtime) &&
      (Personnage::data_personnages_film_ok? File.stat(path_data).mtime)
    end
    
    # Path du fichier définissant les brins
    # @usage : Brin::path
    def path
      @file_brins ||= File.join(Film::folder, "#{Film::affixe}.brins")
    end
    # Path du fichier des données de brin préparés
    # @usage : Brin::path_data
    def path_data
      @path_data ||= File.join(Film::folder, Film::affixe, "brins_data.msh")
    end
    
  end
  
end # class Brin
