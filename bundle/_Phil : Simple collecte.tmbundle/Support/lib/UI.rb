class UI
  
  class << self
    
    # @param items    Soit le Array des éléments de la liste, soit une liste
    #                 type définie par un Symbol connu de `get_liste' plus bas
    def choose_from_list items
      items = get_liste items unless items.class == Array
      cocoaD = (ENV['TM_SUPPORT_PATH'] +
      '/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog').gsub(/ /, "\\ ")
      item_string = items.collect{|e| e.gsub!(/\"/,"\\\""); "\"#{e}\""}.join(' ')
      args = [
        'standard-dropdown',
        '--title "Objet à trouver"',
        '--text "Choisissez le type d’objet à trouver"',
        '--exit-onchange', # -> se ferme après le choix
        '--string-output', # -> nom du bouton cliqué
        '--items ' + item_string,
        '2>/dev/null'
      ]
      cmd = "#{cocoaD} #{args.join(' ')}"
      u_reponse = %x{#{cmd}}
      btn_name, choix = u_reponse.split("\n")
      return nil if btn_name == 'Cancel'
      choix
    end
    
    
    def get_liste list_id
      case list_id
      # Pour choisir un type d'objet
      when :types_objets
        @types_objets ||= Objet::data_types.collect{|tobj, dtype| dtype[:hname] }
      end
    end
  end
  
end