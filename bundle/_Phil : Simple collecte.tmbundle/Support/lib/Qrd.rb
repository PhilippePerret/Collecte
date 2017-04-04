# Gestion des Qd/Rd dans les snippets
require_relative 'direct'
class Qrd
  
  class << self
    
    #---------------------------------------------------------------------
    #   Snippets
    #---------------------------------------------------------------------
    
    # => Code Snippet pour la référence à une QD/RD
    def snippet_for type # :qd ou :rd
      self.send("snippet_for_#{type}".to_sym)
    end
    # => Code Snippet pour une nouvelle QD
    def snippet_for_qd
      "[QD#${1|#{list_qr_et_id(:qd).join(',')}|}]formate_qrd$0"
    end
    def snippet_for_rd
      "[RD#${1|#{list_qr_et_id(:rd).join(',')}|}]formate_qrd$0"
    end
    def snippet_for_qdf
      
    end
    def snippet_for_rdf
      
    end
    
    # => Code Snippet pour une nouvelle QD/RD
    def snippet_for_new type
      self.send("snippet_for_new_#{type}".to_sym)
    end
    
    # => Code Snippet pour une QDF
    def snippet_for_new_qdf
      snippet_for_new_qd
    end
    
    # => Code Snippet pour une RDF
    def snippet_for_new_rdf
      snippet_for_new_rd
    end
    
    # => Code Snippet pour une nouvelle QD
    def snippet_for_new_qd
      "QD##{Objet::next_id_of_type 'QD'}: ${#{Snippet::next_tab}|h,d|}$0"
    end
    
    # => Code Snippet pour une nouvelle RD
    # @note : Nouveau fonctionnement avec l'affichage de la liste des QD
    def snippet_for_new_rd
      qd_id = select_qd_without_rd
      horloge = (Snippet::horloge nil, true) # ici pour le bon tab-stop
      type_reponse = select_type_reponse_rd
      while type_reponse.match(/\[tab_stop\]/)
        type_reponse.sub!(/\[tab_stop\]/, "\${#{Snippet::next_tab}:TEXTE}")
      end
      sn = ""
      sn << "RD##{Objet::next_id_of_type 'RD'}: "
      sn << horloge
      sn << "[QD##{qd_id}] "
      sn << "#{type_reponse}"
      sn << " $0"
      return sn
    end
    
    # Retourne le type de réponse pour la RD (:positive, etc.)
    def select_type_reponse_rd
      types_rd = [
        {htype: "Positive",             str: "OUI [tab_stop]"},
        {htype: "Simple réponse",       str: ""},
        {htype: "Négative",             str: "NON [tab_stop]"},
        {htype: "Positive paradoxale",  str: "OUI [tab_stop] MAIS [tab_stop]"},
        {htype: "Négative paradoxale",  str: "NON [tab_stop] MAIS [tab_stop]"}
      ]
      items_string = types_rd.collect do |dqd|
        '"' + dqd[:htype].gsub(/\"/,"\\\"") + '"'
      end.join(' ')
      args = [
        'dropdown',
        '--title "Type de la réponse dramatique"',
        '--text "Choisir le type de la RD :"',
        '--exit-onchange', # -> se ferme après le choix
        '--button1 "OK"',
        '--items ' + items_string,
        '2>/dev/null'
      ]
      cmd = "#{cocoaD} #{args.join(' ')}"
      u_reponse = %x{#{cmd}}
      btn_name, user_choix = u_reponse.split("\n")
      return nil if btn_name.to_i == 3
      types_rd[user_choix.to_i][:str]
    end
    
    # Retourne l'identifiant de la QD choisie
    def select_qd_without_rd
      qds = hash_qds true
      if qds.empty?
        Snippet::alert "Aucune QD n'est sans réponse dans ce fichier…", "Il faut définir une QD avant de définir sa RD."
      else
        items_string = qds.collect do |dqd|
          dqd[:qd].gsub!(/\"/,"\\\""); "\"#{dqd[:qd]}\""
        end.join(' ')
        args = [
          'dropdown',
          '--title "Choix de la QD"',
          '--text "Choisir la QD à laquelle doit répondre cette RD (seules les QD sans réponse sont listées)"',
          '--exit-onchange', # -> se ferme après le choix
          '--button1 "Choisir cette QD"',
          '--button3 "Renoncer"',
          '--items ' + items_string,
          '2>/dev/null'
        ]
        cmd = "#{cocoaD} #{args.join(' ')}"
        u_reponse = %x{#{cmd}}
        btn_name, user_choix = u_reponse.split("\n")
        return nil if btn_name.to_i == 3
        qds[user_choix.to_i][:id]
      end
    end
    
    def cocoaD
      @cocoaD ||= begin
        (ENV['TM_SUPPORT_PATH'] +
        '/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog').gsub(/ /, "\\ ")
      end
    end
    
    #---------------------------------------------------------------------
    #   Utilitaire
    #---------------------------------------------------------------------
    
    # => Return une liste snippet pour choisir une QD ou chaque QD est
    #    présentée sous la forme "<id QD>::<texte de la QD>"
    # Si +sans_rd+ est true, ne renvoie que la liste des QD sans réponse
    def list_str_des_qds sans_rd = false
      @list_str_des_qds ||= begin
        hash_qds(sans_rd).collect { |dqd| dqd[:qd] }
      end
    end
    
    # => Return une liste Array des QD sous forme ou chaque élément est un hash
    # contenant :
    #   :id (id de la QD) 
    #   :qd (la question string), 
    #   :orpheline (true si pas de RD)
    #    de la QD et en valeur la question
    def hash_qds sans_rd = false
      inp = Snippet::input
      inp.scan(/QD\#([0-9]+)\:(.*)$/).to_a.collect do |found|
        qd_id   = found[0]
        qd_str  = found[1].strip
        orpheline = inp.match(/RD#([^\n]+)\[QD\##{qd_id}\]/).nil?
        if sans_rd == false || orpheline
          {:qd => qd_str, :id => qd_id, :orpheline => orpheline}
        else
          nil
        end
      end.reject{|e| e.nil?}
    end
   
  
    # => Retourne la liste des identifiants de Qd ou Rd
    def list_ids type
      balise = (type == :qd) ? "QD" : "RD"
      Snippet::input.scan(/#{balise}\#([0-9]+)\:/).to_a.collect do |found|
        found[0]
      end
    end
    
    # Retourne une liste avec <question/réponse>::<identifiant>
    def list_qr_et_id type
      @list_qr_et_id ||= begin
        balise = (type == :qd) ? "QD" : "RD"
        Snippet::input.scan(/#{balise}\#([0-9]+)\:(.*)$/).to_a.collect do |found|
          qrd_id    = found[0]
          qrd_texte = found[1]
          "\"#{qrd_texte}::#{qrd_id}\""
        end
      end
    end
    
    # Retourne un hash contenant en clé la question/réponse et en valeur 
    # l'identifiant de la QRD
    def hash_qr2id
      @hash_qr2id ||= begin
        balise = (type == :qd) ? "QD" : "RD"
        h = {}
        Snippet::input.scan(/#{balise}\#([0-9]+)\:(.*)$/).to_a.each do |found|
          qrd_id    = found[0]
          qrd_texte = found[1]
          h = h.merge qrd_texte => qrd_id
        end
      end
    end
  end
  
end