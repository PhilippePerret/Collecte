#!/usr/bin/env ruby -wU
# encoding: UTF-8
#
# Pour lancer le parse d'un dossier de collecte.
#
# Le path absolu du dossier doit être défini ci-dessous.
#

FOLDER_COLLECTE_PATH = "/Users/philippeperret/Desktop/Everest_collect"
options = {
  format:       :html,
  open_file:    true
}
# On parse le dossier de collecte
require_relative 'lib/required'
coll = Collecte.new(FOLDER_COLLECTE_PATH)
coll.parse
coll.extract(options)
