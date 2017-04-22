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
# Mettre à true la constante FORCE_PARSING lorsque des données
# ont été modifiées dans les fichiers de collecte.
FORCE_PARSING = true
# Choisir le format :html, :text ou :xml
OUTPUT_FORMAT = :html
# Si true, affiche les horloges dans la marge gauche
WITH_HORLOGE = true
# Laisser à nil pour commencer à la première scène
FROM_TIME = nil
# Laisser à nil pour aller à la dernière scène
TO_TIME = nil

# / NE RIEN TOUCHER SOUS CETTE LIGNE
# ===========================================================

options = {
  format:       OUTPUT_FORMAT,
  as:           :synopsis,
  horloge:      WITH_HORLOGE,
  open_file:    true
}
FROM_TIME.nil?  || options.merge!(from_time: FROM_TIME)
TO_TIME.nil?    || options.merge!(to_time:   TO_TIME)
require_relative '../../lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
FORCE_PARSING && coll.parse
coll.extract(options)
