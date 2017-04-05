# encoding: UTF-8
#
# GESTION DU FICHIER MARSHAL film.msh
class Film

  # Renvoie un {Hash} de toutes les données du film
  def donnee_totale
    {
      id: id, titre: titre, auteurs: auteurs,
      scenes: nil,
      personnages: nil,
      brins: nil,
      notes: nil,

    }
  end

  # Sauver les données dans le fichier marshal
  def save
    File.open(marshal_file,'wb'){|f| f.write Marshal.dump(donnee_totale)}
  end

  # ---------------------------------------------------------------------
  #   C H A R G E M E N T
  # ---------------------------------------------------------------------

  # Charger les données, mais seulement si elles
  # existent
  def load_if_exist
    File.exist?(marshal_file) && load
  end

  # Charger les données du fichier Marshal
  def load
    File.exist?(marshal_file) || raise('Impossible de charger les données du film : le film `data/film.msh` n’existe pas.')
    @donnee_totale = Marshal.load(File.read(marshal_file))
    dispatch
  end

  def dispatch
    donnee_totale.each do |key, value|
      # TODO à implémenter
    end
  end

  # ---------------------------------------------------------------------

  def marshal_file
    @marshal_file ||= File.join(collecte.data_folder, 'film.msh')
  end

end #/Film
