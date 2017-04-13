# encoding: UTF-8
module CollecteFileMethods

  # = main =
  #
  # Méthode principale qui parse le fichier brins s'il
  # existe et définit le fichier marshal brins.msh associé
  # au film.
  #
  def parse
    collecte_exist? || begin
      log "Pas de fichier #{collecte_file}"
      return
    end
    blocs.each { |bloc| add(bloc) }
  end

  # Tous les blocs du code définissant normalement un élément (i.e.
  # un brin, un personnage, etc.)
  def blocs
    @blocs ||= begin
      # On va maintenant retourner des blocs qui définissent
      # leur première ligne, pour la donnée `line` des scènes,
      # des personnages et des brins
      line_precedente_vide = false
      liste_blocs   = Array.new
      current_lines = Array.new
      File.read(collecte_file).split(RC).each_with_index do |line, index_line|
        # On passe les lignes de commentaire
        false == line.strip.start_with?('#') || next
        # Si la ligne est vide et que la précédente était
        # vide aussi, c'est la définition d'un nouveau
        # bloc.
        if line.strip == ''
          if current_lines.count > 0
            #
            # => Nouveau bloc
            #
            liste_blocs << Bloc.new(current_lines.join(RC), @first_index_line)
            current_lines = Array.new
            @first_index_line = nil
          end
        else
          #
          # => Ligne non vide, on l'ajoute à la liste
          #
          @first_index_line ||= index_line + 1
          current_lines << line
        end
      end
      if current_lines.count > 0
        liste_blocs << Bloc.new(current_lines.join(RC), @first_index_line)
      end
      liste_blocs
    end
  end

  class Bloc
    attr_reader :code, :line
    def initialize code, line
      @code = code.strip
      @line = line
    end
  end

end
