describe 'Suggestion de la structure' do
  let(:collecte) { @collecte }
  let(:code) { @code }
  context 'sans option :suggest_structure' do
    before(:all) do
      @collecte = Collecte.new(folder_test_5)
      @collecte.parse
      @collecte.extract(
        as: :sequencier,
        format: :html,
        suggest_structure: false,
        open_file: false
      )
      extracteur = @collecte.extractor
      @code = File.read(extracteur.final_file.path)
    end
    it 'le séquencier n’affiche pas les points structurels' do
      expect(code).not_to have_tag('div.stt')
    end
  end
  # /sans option :suggest_structure

  context 'avec l’option :suggest_structure' do
    before(:all) do
      @collecte = Collecte.new(folder_test_5)
      @collecte.parse
      @collecte.extract(
        as:                 :sequencier,
        format:             :html,
        suggest_structure:  true,
        open_file:          false
      )
      extracteur = @collecte.extractor
      @code = File.read(extracteur.final_file.path)
    end
    it 'le séquencier affiche tous les points structurels trouvés' do
      [
        'Début de la Zone du Pivot 1',
        'Début du Développement',
        'Début de la Zone du tiers',
        'Fin de la Zone du tiers',
        'Début de la Zone Clé de voûte',
        'Fin de la Zone Clé de voûte',
        'Début de la Zone des deux-tiers',
        'Fin de la Zone des deux-tiers',
        'Début de la Zone du Pivot 2',
        'Début du Dénouement'
      ].each do |expected|
        expect(code).to have_tag('div.stt', text: /#{Regexp.escape expected}/)
      end
    end
    it 'le séquencier n’affiche pas les points structurels non trouvés' do
      [
        'Début de la Zone du Climax'
      ].each do |expected|
        expect(code).not_to have_tag('div.stt', text: /#{Regexp.escape expected}/)
      end
    end
  end
end
