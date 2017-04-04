=begin

Ce module est chargé par tout script de ce module. Il permet de charger et de définir le minimum de choses pour pouvoir utiliser une librairie.

Pour rappel, ces librairies peuvent être utilisées de deux façons :

    * En chargeant tout. Dans ce cas, ce module est inutile
    * En chargement seulement la librairie nécessaire, et dans ce cas, ce module
      permet de définir le minimum que le programme doit connaitre.

Pour appeler seulement une librairie, mettre en haut de la commande :

    require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/<librairie sans .rb>"

Pour tout charger, mettre en haut de la commande : 

    require "#{ENV['TM_BUNDLE_SUPPORT']}/required"

=end
unless defined?(THIS_FOLDER)
  THIS_FOLDER = File.dirname(File.dirname(__FILE__))
end
require "#{THIS_FOLDER}/lib/FilmTM"   # FilmTM
# Film (pour le film courant)
Dir["#{THIS_FOLDER}/lib/Film/**/*.rb"].each{|m| require m}
require "#{THIS_FOLDER}/lib/Snippet"  # Snippet