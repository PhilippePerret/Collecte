# encoding: UTF-8
class Film
class Structure
class Point
class << self

  ABS_POINTS_DATA = {
    inc_dec:    {
      hname: 'Incident déclencheur', short_hname: 'Inc. Déc.',
      pfa: nil, pfa_before: 0.25
    },
    inc_pert:   {
      hname: 'Incident perturbateur', short_hname: 'Inc. Pert.',
      pfa: nil, pfa_before: 0.25
    },
    pivot_1:    {
      hname: 'Pivot 1', short_hname: 'Pvt 1',
      pfa: 0.25, tolerance: 0.24
    },
    pivot_2:    {
      hname: 'Pivot 2', short_hname: 'Pvt 2',
      pfa: 0.75, tolerance: 0.24
    },
    cdv:        {
      hname: 'Clé de voûte', short_hname: 'CdV',
      pfa: 0.5, tolerance: 0.12
    },
    dev_part1:  {
      hname: 'Développement, partie 1', short_hname: 'Dév. part 1',
      pfa: 0.25, tolerance: 0
    },
    dev_part2:  {
      hname: 'Développement, partie 2', short_hname: 'Dév. part 2',
      pfa: 0.5, tolerance: 0
    },
    denouement: {
      hname: 'Dénouement',
      pfa: 0.75, tolerance: 0
    },
    climax:     {
      hname: 'Climax',
      pfa: nil
    },
    crise:      {
      hname: 'Crise',
      pfa: nil
    }
  }
  def name_of point
    ABS_POINTS_DATA[point.id][:hname]
  end
  def short_name_of point
    ABS_POINTS_DATA[point.id][:short_hname] || name_of(point)
  end

end #/<< self
end #/Point
end #/Structure
end #/Film
