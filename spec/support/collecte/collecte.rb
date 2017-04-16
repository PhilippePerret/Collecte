def collecte
  @collecte
end
def film
  @film
end
def parse_collecte dossier
  @collecte = Collecte.new(dossier)
  @collecte.parse
  @film = @collecte.film
end
