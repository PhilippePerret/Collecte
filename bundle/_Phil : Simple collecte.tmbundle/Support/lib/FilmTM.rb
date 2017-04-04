#  Quand on a juste besoin de cette classe, on peut utiliser dans
#  la commande :
#     require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/FilmTM"
# 
unless defined?(THIS_FOLDER)
  THIS_FOLDER = File.dirname(File.dirname(__FILE__))
end
class FilmTM
  
  class << self
    
    # Retourne le path au dossier TM_Film contenant le programme
    # Le cherche s'il n'est pas défini
    def folder
      @folder ||= search_for_folder_film_tm
    end
    
    def folder_data
      @folder_data ||= File.join(FilmTM::folder, 'ruby', 'lib', 'data')
    end
    
    def search_for_folder_film_tm
      if File.exists? folder_path_file
        p = File.read( folder_path_file )
        return p if File.exists?(File.join(p, 'ruby', 'lib', 'required.rb'))
        File.unlink folder_path_file
      end
      # Il faut chercher le dossier
      liste_folders = [Dir.home]
      while fold = liste_folders.pop
        if se_trouve_dans?(fold)
          fold = File.join(fold, 'TM_Film')
          break
        else
          Dir["#{fold}/*"].each do |dos| 
            liste_folders << dos if File.directory? dos
          end
        end
      end 
      File.open(folder_path_file, 'wb'){|f| f.write fold} if File.exists? fold
      return fold
    end
    
    def se_trouve_dans? folder
      pa = File.join(folder, 'TM_Film')
      File.exists?(pa) && File.directory?(pa)
    end
    
    # Le path au fichier contenant l'indication du path du programme Film TM
    def folder_path_file
      @file_data_folder ||= File.join(THIS_FOLDER, 'folder_path')
    end
  end # << self
  
end