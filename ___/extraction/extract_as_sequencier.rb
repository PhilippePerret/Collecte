#!/usr/bin/env ruby -wU
# encoding: UTF-8
#
# Pour lancer le parse d'un dossier de collecte.
#
# Le path absolu du dossier doit être défini ci-dessous.
#
# =============================================================
FOLDER_COLLECTE_PATH = "/Users/philippeperret/Desktop/Everest_collect"
# Choisir le format :html, :text ou :xml
OUTPUT_FORMAT = :html
# Mettre à true la constante ci-dessous si on veut que
# le programme suggère les divisions de la structure
SUGGEST_STRUCTURE = false

# / ne rien toucher sous cette ligne
# =============================================================
options = {
  format:     OUTPUT_FORMAT,
  as:         :sequencier,
  suggest_structure: SUGGEST_STRUCTURE,  # Pour suggérer la structure
  open_file:  true
}
# On parse le dossier de collecte
require_relative '../../lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
# coll.parse
coll.extract(options)
