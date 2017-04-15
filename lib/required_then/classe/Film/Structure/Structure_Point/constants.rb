# encoding: UTF-8
class Film
class Structure
class Point

  ABS_POINTS_DATA = {
    inc_dec:    {
      de_l: 'de l’',
      hname: 'Incident déclencheur', short_hname: 'Inc. Déc.',
      coefpos: nil, coef_before: 0.25
    },
    inc_pert:   {
      de_l: 'de l’',
      hname: 'Incident perturbateur', short_hname: 'Inc. Pert.',
      coefpos: nil, coef_before: 0.25
    },
    pivot_1:    {
      de_l: 'du',
      hname: 'Pivot 1', short_hname: 'Pvt 1',
      coefpos: 0.25, tolerance: 1.0/24
    },
    pivot_2:    {
      de_l: 'du',
      hname: 'Pivot 2', short_hname: 'Pvt 2',
      coefpos: 0.75, tolerance: 1.0/24
    },
    cle_de_voute: {
      de_l: 'de la',
      hname: 'Clé de voûte', short_hname: 'CdV',
      coefpos: 0.5, tolerance: 1.0/12
    },
    dev_part1:  {
      de_l: 'du',
      hname: 'Développement, partie 1', short_hname: 'Dév. part 1',
      coefpos: 0.25, tolerance: 1.0/24
    },
    dev_part2:  {
      de_l: 'du',
      hname: 'Développement, partie 2', short_hname: 'Dév. part 2',
      coefpos: 0.5, tolerance: 1.0/24
    },
    denouement: {
      de_l: 'du',
      hname: 'Dénouement',
      coefpos: 0.75, tolerance: 1.0/24
    },
    climax:     {
      de_l: 'du',
      hname: 'Climax',
      coefpos: nil, coef_after: 0.75 + 1.0/24
    },
    crise:      {
      de_l: 'de la',
      hname: 'Crise',
      coefpos: nil
    }
  }

end #/Point
end #/Structure
end #/Film
