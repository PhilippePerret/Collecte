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
# Mettre la liste des brins ici. Voir les options pour le détail.
# Rapidement : utiliser des virgules pour OU et des + pour ET.
# '1,2' => les scènes doivent appartenir au brin 1 OU au brin 2
# '1+2' => les scènes doivent appartenir au brin 1 ET au brin 2
# On peut utiliser aussi des tournures comme '1+(2,4)'
BRINS = '1,2'
# === OPTIONS ===
# Mettre à true la constante FORCE_PARSING lorsque des données
# ont été modifiées dans les fichiers de collecte.
FORCE_PARSING = false
# Choisir le format :html, :text ou :xml
OUTPUT_FORMAT = :html
# Laisser à nil pour commencer à la première scène
FROM_TIME = nil
# Laisser à nil pour aller à la dernière scène
TO_TIME = nil
# Mettre à true si on ne veut pas que le résumé de la scène
# soit affiché lorsque seulement un paragraphe ou plusieurs
# sont dans le brin, mais pas la scène elle-même
NO_RESUME_WHEN_PARAGRAPHES = true

# / NE RIEN TOUCHER SOUS CETTE LIGNE
# ===========================================================

options = {
  format:       OUTPUT_FORMAT,
  as:           :brin,
  brins:        BRINS,
  open_file:    true
}
FROM_TIME.nil?  || options.merge!(from_time: FROM_TIME)
TO_TIME.nil?    || options.merge!(to_time:   TO_TIME)
NO_RESUME_WHEN_PARAGRAPHES && options.merge!(no_resume_when_paragraphes: true)
require_relative '../../lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
FORCE_PARSING && coll.parse
coll.extract(options)
