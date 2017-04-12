# encoding: UTF-8

# Méthode pour extraire un séquencier avec des options
# particulière.
#
# Par défaut, c'est le troisième dossier test de collecte
# qui est utilisé.
#
# Pour tester le code, ajouter au test :
#   let(:collecte){@collecte}
#   let(:code){@code}
#
def extract_sequencier options_sup, dossier = nil
  dossier ||= folder_test_3
  opts = {
    format:     :html,
    as:         :sequencier
  }
  opts.merge!(options_sup)
  extraction_with_option(dossier, opts)
end

# +cond_brins+ est un filtre comme '1+(2,3)'. Cf. le
# manuel
def extract_brin cond_brins, options_sup = nil, dossier = nil
  dossier ||= folder_test_4
  opts = {
    format:     :html,
    as:         :brin,
    filter:     {brins: cond_brins}
  }
  options_sup.nil? || opts.merge!(options_sup)
  extraction_with_option(dossier, opts)
end

def extraction_with_option dossier, options
  options[:format] ||= :html
  @collecte = Collecte.new(dossier)
  @collecte.extract(options)
  @code = File.read(@collecte.extractor(options[:format]).final_file.path)
  @nombre_de_scenes = @nombre_scenes = @collecte.film.scenes.count
end
