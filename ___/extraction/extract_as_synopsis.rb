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
# Choisir le format :html, :text ou :xml
OUTPUT_FORMAT = :html
# Si true, affiche les horloges dans la marge gauche
WITH_HORLOGE = true

# / NE RIEN TOUCHER SOUS CETTE LIGNE
# ===========================================================

options = {
  format:       OUTPUT_FORMAT,
  as:           :synopsis,
  horloge:      WITH_HORLOGE,
  open_file:    true
}
# On parse le dossier de collecte
require_relative '../../lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
# coll.parse
coll.extract(options)
