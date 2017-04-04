#!/usr/bin/env ruby
# encoding: UTF-8

# Pour utiliser cette librairie, ajouter la ligne :
#     require "#{ENV['TM_BUNDLE_SUPPORT']}/required"
# en haut des commandes

# Pour obtenir des données du dossier TM_Film :
# FilmTM::folder renvoie le path au dossier
# @note: Il est cherché sur le disque

THIS_FOLDER = File.dirname(__FILE__)
Dir["#{THIS_FOLDER}/lib/**/*.rb"].each{|m| require m}


