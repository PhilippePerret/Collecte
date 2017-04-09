# encoding: UTF-8
#
# Méthodes pour gérer les divisions dans le film
#
# Ces méthodes permettent de faire des marques sur la timeline
# ou dans les séquenciers pour signaler les changements de
# parties, quarts, tiers, etc.
#
class Film

  def vingtquatrieme
    @vingtquatrieme ||= duree / 24
  end
  def real_quart
    @real_quart ||= duree / 4
  end

  # Le quart relatif, en fonction du temps de la première
  # scène
  def quart
    @quart ||= real_quart + start.time
  end

  def real_moitie
    @real_moitie ||= duree / 2
  end
  def moitie
    @moitie ||= real_moitie + start.time
  end

  def real_trois_quarts
    @real_trois_quarts ||= 3*real_quart
  end
  def trois_quarts
    @trois_quarts ||= real_trois_quarts + start.time
  end

  def real_tiers
    @tiers ||= duree / 3
  end
  def tiers
    @tiers ||= real_tiers + start.time
  end

  def real_deux_tiers
    @real_deux_tiers ||= 2 * real_tiers
  end
  def deux_tiers
    @deux_tiers ||= real_deux_tiers + start.time
  end

  def zone_pivot_1
    @zone_pivot_1 ||= begin
      h = Film::Horloge.new(self,(quart - vingtquatrieme).s2h)
      h.duree = vingtquatrieme
      h
    end
  end

  def zone_pivot_2
    @zone_pivot_2 ||= begin
      h = Film::Horloge.new(self,(trois_quarts - vingtquatrieme).s2h)
      h.duree = vingtquatrieme
      h
    end
  end

  def zone_cle_de_voute
    @zone_cle_de_voute ||= begin
      h = Film::Horloge.new(self,(moitie - vingtquatrieme).s2h)
      h.duree = 2 * vingtquatrieme
      h
    end
  end


end #/Film
