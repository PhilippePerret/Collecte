describe 'Extraction d’un brin avec option as: :brin' do
  let(:collecte) { @collecte }
  let(:brin_path) { @brin_path }
  let(:code) { @code ||= File.exist?(brin_path) ? File.read(brin_path) : nil}

  context 'avec un seul brin, en nombre (@collecte.extract(as: :brin, brin: 4))' do
    before(:all) do
      @collecte = Collecte.new(folder_test_4)
      @collecte.extract(as: :brin, brin: 3)
      extracteur = @collecte.extractor
      puts "Fichier final : #{extracteur.final_file.path}"
      @brin_path = File.join(extracteur.final_file.folder, 'brin_3.html')
    end
    it 'crée le fichier brin brin_3.html' do
      expect(File.exist? brin_path).to eq true
    end
    describe 'le code du fichier' do
      it 'contient le bon titre' do
        expect(code).to have_tag('div#titre', text: "Brin 3 du film “Film pour brins”")
      end
      it 'contient les scènes du brin' do
        [3,4,5].each do |num|
          expect(code).to have_tag("div#scene-#{num}")
        end
      end
      it 'ne contient pas les scènes hors du brin' do
        [1,2,6,7].each do |num|
          expect(code).not_to have_tag("div#scene-#{num}")
        end
      end
      it 'contient la timeline' do
        expect(code).to have_tag('div.timeline')
      end
      it 'contient les blocs de scènes timeline des scènes du brin' do
        [3,4,5].each do |num|
          expect(code).to have_tag("div#tl-sc-#{num}")
        end
      end
      it 'ne contient pas les blocs de scènes timeline des scènes hors brin' do
        [1,2,6,7].each do |num|
          expect(code).not_to have_tag("div#tl-sc-#{num}")
        end
      end
    end
  end

  context 'avec un seul brin, en string ((@collecte.extract(as: :brin, brin: \'4\')))' do
    before(:all) do
      @collecte = Collecte.new(folder_test_4)
      @collecte.extract(as: :brin, brin: '4')
      @brin_path = File.join(@collecte.extraction_folder, 'brin_4.html')
      @code = File.read(@brin_path)
    end
    it 'crée le fichier brin_4.html' do
      expect(File.exist?(brin_path)).to eq true
    end
    it 'sort un fichier correct' do
      pending
    end
    it 'contient la timeline' do
      pending
    end
    it 'contient les blocs scène de timeline' do
      pending
    end
  end


  context "avec deux brins (@collecte.extract(as: :brin, brin: '2+4'))" do
    before(:all) do
      @collecte = Collecte.new(folder_test_4)
      @collecte.extract(as: :brin, brin: '2+4')
      @brin_path = File.join(@collecte.extraction_folder, 'brin_2_4.html')
    end
    it 'crée le fichier brin_2_4.html' do
      expect(File.exist?(brin_path)).to eq true
    end
    it 'sort un fichier correct' do
      pending
    end
    it 'contient la timeline' do
      pending
    end
    it 'contient les blocs scène de timeline' do
      pending
    end
  end

  context 'avec deux brins sans timeline' do
    before(:all) do
      @collecte = Collecte.new(folder_test_4)
      @collecte.extract(as: :brin, brin: '2+4', no_timeline: true)
      @code = File.read(File.join(@collecte.extraction_folder, 'brin_2_4.html'))
    end
    it 'crée le fichier `brin_2_4.html`' do
      expect(File.exist? brin_path).to eq true
    end
    it 'sort un fichier correct' do
      pending
    end
    it 'ne contient pas la timeline' do
      expect(code).not_to have_code('div.timeline')
    end
    it 'ne contient pas les blocs scène de timeline' do
      pending
    end

  end
end
