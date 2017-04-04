class Objet
  
  class << self
    
    # Le texte complet
    attr_reader :texte
    
    # Retourne les données des types d'objets
    def data_types
      @data_types ||= begin
        require File.join(FilmTM::folder_data, 'types_objets')
        TYPES_FILMOBJETS
      end
    end
    
    # Retourne le type Symbol d'après le type humain +htype+
    def htype_to_type htype
      data_types.each do |ktype, dtype|
        return ktype if dtype[:hname] == htype
      end
      raise "Impossible de trouver le type #{htype}…"
    end
    
    # Relève tous les objets de type +type+ dans le texte (doit être donné en
    # entrée de la commande/snippet).
    # Procède ligne par ligne pour pouvoir enregistrer la ligne de l'objet
    # (pour un lien `txmt')
    # @param otype  Symbol Type de l'objet (dans TYPES_FILMOBJETS)
    def search_objets_of_type otype
      str = Snippet::input
      lines = str.split("\n")

      searched = case otype
      when :scene       then %r{SCENE\:}
      when :personnage  then %r{PERSO#([^\:]+)\:}
      else %r{#{otype.upcase}#([^\:]+)\:}
      end
        
      lines.count.times.collect do |iline|
        line = lines[iline]
        unless line.match(searched).nil?
          if otype == :scene
            inext = 0
            inext += 1 until lines[iline + inext].match(/RESUME:/)
            line += (" | " + lines[iline + inext].sub(/RESUME:/,''))
          end
          {line_num: iline + 1, line_str: line }
        end
      end.reject{|e| e.nil?}
    end
    
    # => Retourne un identifiant inutilisé pour le type +type+
    # @param type   Soit un symbol (pe :rd) soit le type majuscule (pe : "QD")
    def next_id_of_type type
      @texte = Snippet::input
      ids = ids_balises_of_type_in_texte type
      (ids.max || 0) + 1
    end
    
    def ids_balises_of_type_in_texte type
      texte.scan(/(?:[ \t]*)#{type.upcase}\#([0-9]+)\:/).to_a.collect do |found|
        found[0].to_i
      end
    end
    
  end # << self Objet
  
end