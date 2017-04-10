# encoding: UTF-8
class CFile

  # Méthode utilisée pour s'assurer que le path du fichier
  # est défini avant l'utilisation de certaines méthodes.
  def raise_if_path_undefined
    @path != nil || raise('Le path doit être défini.')
  end

end
