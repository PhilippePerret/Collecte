#!/usr/bin/env ruby -wU
# encoding: UTF-8
#
# Pour lancer le parse d'un dossier de collecte.
#
# Le path absolu du dossier doit être défini ci-dessous.
#

# === PATH DU DOSSIER COLLECTE ===
FOLDER_COLLECTE_PATH = "/Users/philippeperret/Desktop/Everest_collect"
# === OPTIONS ===
WITH_HORLOGE = true # mettre à false pour retirer les horloges

# / NE RIEN TOUCHER SOUS CETTE LIGNE
# ===========================================================

options = {
  format:       :html,
  as:           :synopsis,
  horloge:      WITH_HORLOGE,
  open_file:    true
}
# On parse le dossier de collecte
require_relative 'lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
# coll.parse
coll.extract(options)
