#!/usr/bin/env ruby -wU
# encoding: UTF-8
#
# Pour lancer le parse d'un dossier de collecte.
#
# Le path absolu du dossier doit être défini ci-dessous.
#

FOLDER_COLLECTE_PATH = "/Users/philippeperret/Desktop/Everest_collect"

# On parse le dossier de collecte
require_relative 'lib/required'
collecte = Collecte.new(FOLDER_COLLECTE_PATH)
collecte.parse(debug: true)
