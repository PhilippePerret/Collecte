describe 'Séquencier partiel' do
  let(:collecte) { @collecte }
  let(:code) { @code }
  context 'avec from_time défini' do
    context 'après la dernière scène' do
      # From_time (mal) défini après la dernière scène
      before(:all) do
        # On force le parsing dans le cas où il y ait des
        # modifications.
        # Collecte.new(folder_test_3).parse

        # Nouvelle instance pour forcer le chargement
        @collecte = Collecte.new(folder_test_3)
        @collecte.extract(format: :html, as: :sequencier, from_time: '0:05:00')
        @code = File.read(@collecte.extractor(:html).final_file.path)
        # puts "@code = #{RC}#{@code}"
      end
      it 'aucune scène n’est inscrite' do
        (1..4).each do |num_scene|
          expect(code).not_to have_tag("div#scene-#{num_scene}")
        end
      end
      it 'un message d’erreur a été enregistré' do
        errors = collecte.errors
        expect(errors).not_to eq nil
        expect(errors.first).to match /### ERREUR(.*?): Aucune scène n'est comprise entre 0:05:00 et la fin du film\./
      end
    end
    context 'avant la dernière scène' do
      before(:all) do
        # On force le parsing dans le cas où il y ait des
        # modifications.
        # Collecte.new(folder_test_3).parse

        # Nouvelle instance pour forcer le chargement
        @collecte = Collecte.new(folder_test_3)
        @collecte.extract(format: :html, as: :sequencier, from_time: '0:03:00')
        @code = File.read(@collecte.extractor(:html).final_file.path)
        # puts "@code = #{RC}#{@code}"
      end
      it 'les scènes voulues sont affichées' do
        (3..4).each do |num_scene|
          expect(code).to have_tag("div#scene-#{num_scene}")
        end
      end
      it 'les scènes non voulues ne sont pas affichées' do
        (1..2).each do |num_scene|
          expect(code).not_to have_tag("div#scene-#{num_scene}")
        end
      end
    end
  end
  context 'avec to_time défini' do
    context 'avant la première scène' do
      before(:all) do
        # On force le parsing dans le cas où il y ait des
        # modifications.
        # Collecte.new(folder_test_3).parse

        # Nouvelle instance pour forcer le chargement
        @collecte = Collecte.new(folder_test_3)
        @collecte.extract(format: :html, as: :sequencier, to_time: '0:00:20')
        @code = File.read(@collecte.extractor(:html).final_file.path)
        # puts "@code = #{RC}#{@code}"
      end
      it 'aucune scène n’est affichée' do
        (1..4).each do |num_scene|
          expect(code).not_to have_tag("div#scene-#{num_scene}")
        end
      end
      it 'un message d’erreur est enregistré' do
        errors = collecte.errors
        expect(errors).not_to eq nil
        expect(errors.first).to match /### ERREUR(.*?): Aucune scène n'est comprise entre le début du film et 0:00:20\./
      end
    end
    context 'après la première scène' do
      before(:all) do
        # On force le parsing dans le cas où il y ait des
        # modifications.
        # Collecte.new(folder_test_3).parse

        # Nouvelle instance pour forcer le chargement
        @collecte = Collecte.new(folder_test_3)
        @collecte.extract(format: :html, as: :sequencier, to_time: '0:03:00')
        @code = File.read(@collecte.extractor(:html).final_file.path)
        # puts "@code = #{RC}#{@code}"
      end
      it 'les scènes demandées sont affichées' do
        (1..2).each do |num_scene|
          expect(code).to have_tag("div#scene-#{num_scene}")
        end
      end
      it 'les scènes non demandées ne sont pas affichées' do
        (3..4).each do |num_scene|
          expect(code).not_to have_tag("div#scene-#{num_scene}")
        end
      end
    end
  end

  context 'avec from_time et to_time définis (en horloge)' do
    before(:all) do
      # On force le parsing dans le cas où il y ait des
      # modifications.
      # Collecte.new(folder_test_3).parse

      # Nouvelle instance pour forcer le chargement
      @collecte = Collecte.new(folder_test_3)
      @collecte.extract(format: :html, as: :sequencier, from_time: '1:40', to_time: '4:50')
      @code = File.read(@collecte.extractor(:html).final_file.path)
      # puts "@code = #{RC}#{@code}"
    end
    it 'les scènes demandées sont affichées' do
      [2,3].each do |num_scene|
        expect(code).to have_tag("div#scene-#{num_scene}")
      end
    end
    it 'aucune erreur n’a été signalée' do
      [1,4].each do |num_scene|
        expect(code).not_to have_tag("div#scene-#{num_scene}")
      end
    end
  end

  context 'avec from_time et to_time définis (en nombre de secondes)' do
    before(:all) do
      # On force le parsing dans le cas où il y ait des
      # modifications.
      # Collecte.new(folder_test_3).parse

      # Nouvelle instance pour forcer le chargement
      @collecte = Collecte.new(folder_test_3)
      @collecte.extract(format: :html, as: :sequencier, from_time: 60, to_time: 3*60)
      @code = File.read(@collecte.extractor(:html).final_file.path)
      # puts "@code = #{RC}#{@code}"
    end
    it 'les scènes demandées sont affichées' do
      [2].each do |num_scene|
        expect(code).to have_tag("div#scene-#{num_scene}")
      end
    end
    it 'aucune erreur n’a été signalée' do
      [1,3,4].each do |num_scene|
        expect(code).not_to have_tag("div#scene-#{num_scene}")
      end
    end
  end

end
