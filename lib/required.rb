# encoding: UTF-8
=begin

  Module permettant de requérir tout ce qui doit l'être.

=end
require 'fileutils'

# En attendant que la vraie méthode log soit chargée
def log mess, opts=nil; end

# Méthode pour charger un dossier de module
#
# Si le dossier +dossier+ contient un dossier _first_required_
# il sera chargé en premier.
#
def require_folder dossier
  # log("require_folder #{dossier}")
  first_required_folder = File.join(dossier, '_first_required_')
  File.exist?(first_required_folder) && require_folder(first_required_folder)
  Dir["#{dossier}/**/*.rb"].each do |m|
    # log "-- require #{m}"
    require m
  end
end


defined?(MAIN_FOLDER) || begin
  MAIN_FOLDER = File.dirname(File.dirname(File.expand_path(__FILE__)))
end
LIB_FOLDER  = File.join(MAIN_FOLDER, 'lib')

REQUIRED_FIRST_FOLDER = File.join(LIB_FOLDER, 'required_first')
# À partir de là, on peut logguer
REQUIRED_THEN_FOLDER  = File.join(LIB_FOLDER, 'required_then')

require_folder REQUIRED_FIRST_FOLDER
require_folder REQUIRED_THEN_FOLDER

log "Fin du chargement des librairies (lib/required.rb)"
