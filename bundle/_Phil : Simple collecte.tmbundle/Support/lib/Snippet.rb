# Utilitaires pour les snippets
require_relative 'Objet'
class Snippet
  
  class << self

    # Pour obtenir l'indice de la prochaine stop-tab à utiliser
    attr_writer :next_tab
    
    def next_tab
      @next_tab ||= 0
      @next_tab += 1
    end
    
    # Plusieurs programmes pouvant utiliser STDIN.read (ce qui efface l'entrée),
    # il ne faut pas appeler STDIN.read mais Snippet::input
    def input
      @input ||= STDIN.read
    end
    
    def alert str, info = ""
      cocoaD = (ENV['TM_SUPPORT_PATH'] +
      '/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog').gsub(/ /, "\\ ")
      args = [
        'msgbox',
        '--alertStyle warning', # un des "styles" ci-dessus
        '--title "Erreur sur la commande demandée"',
        "--text \"#{str}\"",
        "--informative-text \"#{info}\"",
        '--button1 "OK"',
        # '--string-output', # retourne le nom du bouton au lieu du numéro 0-start
        '2>/dev/null'
      ]
      cmd = "#{cocoaD} #{args.join(' ')}"
      %x{#{cmd}}
    end
    
    # => Return le code pour entrer l'une nouvelle horloge de temps
    # @param tab_stop   Numéro de la première stop-tabulation (${<STAB>:....})
    #                   Si nil, on prend la prochaine naturelle
    # @param supprimable  On peut rendre cette horloge supprimable s'il n'y a pas
    #                     trop de tabs.
    def horloge tab_stop = nil, supprimable = true
      tab_stop ||= next_tab
      tab_stop -= 1
      snip = ""
      snip << "${#{tab_stop+=1}:" if supprimable
      snip << "${#{tab_stop+=1}:0}:${#{tab_stop+=1}:00}:${#{tab_stop+=1}:00}"
      snip << " }" if supprimable
      self.next_tab = tab_stop + 1
      snip
    end
    
    # => Return le code pour un objet simple
    # par exemple : `IDEE#<identifiant>: horloge/durée $0'
    def simple_snippet_for type
      "#{type.upcase}##{Objet::next_id_of_type type}: ${1|,h,d|}$0"
    end
    
    # => Return le code snippet pour un objet particulier
    def snippet_for type
      case type
      when :info
        "#{type.to_s.upcase}##{Objet::next_id_of_type type}: #{horloge}:${#{next_tab}|#{Info::type_list.join(',')}|} $0"
      when 'PROCEDE' 
        Procede::snippet_categories
      else
        raise "Type de snippet inconnu (utiliser plutôt Snippet::simple_snippet_for ?)"
      end
    end
    
  end # << self Objet
  
end