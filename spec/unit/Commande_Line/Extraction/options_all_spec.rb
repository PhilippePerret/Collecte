describe '--all en ligne de commande' do
  let(:dossier_extraction) { @dossier_extraction }
  FILE_LIST = [
    ['statistiques', 'full_statistiques'],
    ['résumé', 'resume'],
    ['synopsis', 'full_synopsis'],
    ['séquencier', 'full_sequencier'],
    ['séquencier (suggestion structure)', 'full_sequencier_suggest_stt'],
    ['du brin 1', 'full_brin_1'],
    ['du brin 2', 'full_brin_2'],
    ['brin de Jan', 'full_brin_jan'],
    ['brin de Joe', 'full_brin_joe'],
    ['brin relation Jan et Joe', 'full_brin_relation_jan_joe']
  ]

  context 'avec l’option complète --all' do
    before(:all) do
      # On détruit le fichier extraction
      @dossier_extraction = File.join(folder_test_3, 'extraction')
      FileUtils.rm_rf @dossier_extraction if File.exist? @dossier_extraction
      parse_collecte(folder_test_3)
      expect(File.exist? @dossier_extraction).to eq false
      # ===> TEST <===
      `cd "#{folder_test_3}";collecte extract --all`
    end
    describe 'a été produit' do
      it 'le dossier d’extraction' do
        expect(File.exist? dossier_extraction).to eq true
      end
      FILE_LIST.each do |paire|
        fname, faffixe = paire
        it "le fichier #{fname} existe" do
          fpath = File.join(dossier_extraction, "#{faffixe}.html")
          expect(File.exist? fpath).to eq true
        end
      end
    end
  end

  context 'avec l’option réduite -a' do
    before(:all) do
      # On détruit le fichier extraction
      @dossier_extraction = File.join(folder_test_3, 'extraction')
      FileUtils.rm_rf @dossier_extraction if File.exist? @dossier_extraction
      parse_collecte(folder_test_3)
      expect(File.exist? @dossier_extraction).to eq false
      # ===> TEST <===
      `cd "#{folder_test_3}";collecte extract -a`
    end
    describe 'a été produit' do
      it 'le dossier d’extraction' do
        expect(File.exist? dossier_extraction).to eq true
      end
      FILE_LIST.each do |paire|
        fname, faffixe = paire
        it "le fichier #{fname} existe" do
          fpath = File.join(dossier_extraction, "#{faffixe}.html")
          expect(File.exist? fpath).to eq true
        end
      end
    end
  end
end
