#!/usr/bin/env ruby -wU
# encoding: UTF-8
#
# Pour lancer le parse d'un dossier de collecte.
#
# Le path absolu du dossier doit être défini ci-dessous.
#
# =============================================================
FOLDER_COLLECTE_PATH =
"/Users/philippeperret/Desktop/Everest_collect"
# Mettre à true la constante FORCE_PARSING lorsque des données
# ont été modifiées dans les fichiers de collecte.
FORCE_PARSING = true
# Choisir le format :html, :text ou :xml
OUTPUT_FORMAT = :html
# Mettre à true la constante ci-dessous si on veut que
# le programme suggère les divisions de la structure
SUGGEST_STRUCTURE = true
# Laisser à nil pour commencer à la première scène
FROM_TIME = nil
# Laisser à nil pour aller à la dernière scène
TO_TIME = nil

# / ne rien toucher sous cette ligne
# =============================================================
options = {
  format:     OUTPUT_FORMAT,
  as:         :sequencier,
  suggest_structure: SUGGEST_STRUCTURE,  # Pour suggérer la structure
  open_file:  true
}
FROM_TIME.nil?  || options.merge!(from_time: FROM_TIME)
TO_TIME.nil?    || options.merge!(to_time:   TO_TIME)
# On parse le dossier de collecte
require_relative '../../lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
FORCE_PARSING && coll.parse
coll.extract(options)
