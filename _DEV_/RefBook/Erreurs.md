
## Produire une erreur non fatale {#erreur_non_fatale}

> Cette erreur sera enregistrée dans le log, mais ne produira pas d'arrêt du programme.

    rescue Exception => e
      log "Message littéraire", error: e
    end

## Produire une erreur fatale {#erreur_fatale}

    rescue Exception => e
      log "Un message d'introduction", fatal_error: e
    end
