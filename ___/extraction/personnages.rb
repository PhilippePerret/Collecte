#!/usr/bin/env ruby -wU
# encoding: UTF-8
#
# Pour lancer le parse d'un dossier de collecte.
#
# Le path absolu du dossier doit être défini ci-dessous.
#

# === PATH DU DOSSIER COLLECTE ===
FOLDER_COLLECTE_PATH =
"/Users/philippeperret/Desktop/Everest_collect"
# === OPTIONS ===
# Définir les personnages dont il faut faire le brin. Si
# la donnée est nil ou :all, tous les personnages sont traités.
# Sinon, ne mettre que les personnages qu'on veut.
PERSONNAGES = nil # ou :all
# PERSONNAGES = ['idpremier', 'iddeuxieme', 'idtroisieme']
# Mettre à true la constante FORCE_PARSING lorsque des données
# ont été modifiées dans les fichiers de collecte.
FORCE_PARSING = true
# Choisir le format :html, :text ou :xml
OUTPUT_FORMAT = :html
# Laisser à nil pour commencer à la première scène
FROM_TIME = nil
# Laisser à nil pour aller à la dernière scène
TO_TIME = nil
# Par défaut, on n'ouvre pas les fichiers, car il peut y en avoir
# beaucoup. Mettre cette constante à true dans le cas où on veut
# ouvrir tous les fichiers produits
OPEN_FILE = false

# / NE RIEN TOUCHER SOUS CETTE LIGNE
# ===========================================================

options = {
  format:         OUTPUT_FORMAT,
  force_parsing:  FORCE_PARSING,
  open_file:      OPEN_FILE
}
FROM_TIME.nil?  || options.merge!(from_time: FROM_TIME)
TO_TIME.nil?    || options.merge!(to_time:   TO_TIME)
require_relative '../../lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
# Un seul personnage ou tous
if PERSONNAGES == :all || PERSONNAGES == nil
  coll.extract(:all_personnages, options)
else
  options.merge!(
    personnages:  PERSONNAGES,
    as:           :brin_personnage
    )
end
