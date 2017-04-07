class Collecte
class << self

  # Charge le module +name+ du dossier ./module
  def load_module name
    module_path = File.join(module_folder, name)
    if File.exist? module_path
      require_folder module_path
    else
      raise "Impossible de trouver le module #{module_path}…"
    end
  end
  alias :require_module :load_module


  def module_folder
    @module_folder ||= File.join(MAIN_FOLDER, 'module')
  end
end #/<< self
end #/Collecte
