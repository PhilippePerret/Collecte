require_relative 'direct'
class Personnage
  class << self
    
    # => Return la liste des identifiants des personnages du film
    def list_ids
      file_exists? || begin
        Snippet.alert "Le fichier personnages n'existe pas pour ce film. Consulter l'aide pour le créer."
        return nil
      end
      strperso = File.read(path)
      l = []
      strperso.gsub(/^PERSONNAGE\:(.+)$/){l << $1}
      l
    end
    
    # => True si les données personnages n'ont pas été modifiée depuis
    # la date +date+
    def data_personnages_film_ok? date
      File.stat(path).mtime < date
    end
    
    def file_exists?
      File.exists? path
    end
    
    # Le path au fichier des personnages.
    # Il s'agit soit du fichier de simple collecte, soit
    # du fichier du film. Dans les deux cas, le fichier 
    # est constitué de la même façon.
    def path
      @path ||= begin
        if File.exist?(path_simple_collecte)
          path_simple_collecte
        else
          File.join(Film::folder, "#{Film::affixe}.persos")
        end
      end
    end
    def path_simple_collecte
      @path_simple_collecte ||= File.join(Film::folder, "persos.simple_collecte")      
    end
  end
end # class Personnage
