# encoding: UTF-8
=begin

Ce fichier permet de charger seulement l'aide de l'application
SimpleCollecte.

=end
# Retour de chariot, quel que soit le système d'exploitation
defined?(RC) || begin
  RC = <<-EOT

  EOT
end

FOLDER_AIDE = File.dirname(File.expand_path(__FILE__))
FOLDER_LIB_AIDE = File.join(FOLDER_AIDE,'lib')

# On charge tout le dossier d'aide
Dir["#{FOLDER_LIB_AIDE}/**/*.rb"].each{|m|require m}
