#!/usr/bin/env ruby -wKU
# encoding: UTF-8
#
# Fichier appelé par le script /Applications/Collecte.app/Contents/MacOS/Collecte
#
# Ça pourrait être le script lui-même, mais le temps du
# développement, on laisse le dossier de l'application dans le
# dossier programmation.
#

require_relative 'lib/required'

case ARGV.first
when 'help'
  #
  # => Ouverture du manuel de l'application
  #
  log "HELP DEMANDÉE PAR LIGNE DE COMMANDE"
  extension = ARGV[1] || 'html'
  ['pdf', 'html'].include?(extension) || extension = 'html'
  `open "#{MAIN_FOLDER}/Manuel/Manuel.#{extension}"`

when 'parse', 'extract'

  Collecte.parse_commande
  Collecte.check_collecte_folder || raise

  collecte = Collecte.new(Collecte.command_folder)

  case Collecte.command
  when 'parse'
    #
    # => Parsing du dossier de collecte
    #
    log "PARSING DEMANDÉ PAR LIGNE DE COMMANDE"
    log "Commande : collecte.parse(#{Collecte.command_options.inspect})"
    collecte.parse(Collecte.command_options)
  when 'extract'
    #
    # => Extraction des fichiers
    #
    log "EXTRACTION DEMANDÉE PAR LIGNE DE COMMANDE"
    log "Commande : collecte.extract(#{Collecte.command_options.inspect})"
    collecte.extract(Collecte.command_options)
  end
else
  `open "#{MAIN_FOLDER}/_DEV_/collecte.html"`
end
