describe 'Extraction des brins des personnages en ligne de commande' do
  before(:all) do
    @dosext = File.join(folder_test_5,'extraction')
    FileUtils.rm_rf(@dosext) if File.exist? @dosext
    parse_collecte(folder_test_5)
  end
  describe 'la commande `collecte extract --all_personnages`' do
    before(:all) do
      remove_folder_extraction_of(folder_test_5)
      `cd "#{folder_test_5}";collecte extract --all_personnages`
    end
    it 'extrait tous les personnages' do
      personnages_folder_5.each do |pid, pdata|
        fpath = File.join(@dosext, "full_brin_#{pid}.html")
        expect(File.exist? fpath).to eq true
      end
    end
  end

  describe 'La commande `collecte extract --personnage=joe`' do
    before(:all) do
      remove_folder_extraction_of(folder_test_5)
      `cd "#{folder_test_5}";collecte extract --personnage=joe`
    end
    it 'extrait le brin de Joe' do
      fpath = File.join(@dosext, "full_brin_joe.html")
      expect(File.exist? fpath).to eq true
    end
    it 'n’extrait pas les brins des autres personnages' do
      personnages_folder_5.each do |pid, pdata|
        pid != 'joe' || next
        fpath = File.join(@dosext, "full_brin_#{pid}.html")
        expect(File.exist? fpath).to eq false
      end
    end
  end

  describe 'La commande réduite `collecte extract -p=jan`' do
    before(:all) do
      remove_folder_extraction_of(folder_test_5)
      `cd "#{folder_test_5}";collecte extract -p=jan`
    end
    it 'extrait le brin de Jan' do
      fpath = File.join(@dosext, "full_brin_jan.html")
      expect(File.exist? fpath).to eq true
    end
    it 'n’extrait pas les brins des autres personnages' do
      personnages_folder_5.each do |pid, pdata|
        pid != 'jan' || next
        fpath = File.join(@dosext, "full_brin_#{pid}.html")
        expect(File.exist? fpath).to eq false
      end
    end
  end

  describe 'La commande `collecte extract -p=jan,joe,trois`' do
    before(:all) do
      remove_folder_extraction_of(folder_test_5)
      `cd "#{folder_test_5}";collecte extract -p=jan,joe,trois`
    end
    it 'extrait les brins de jan, joe et trois' do
      ['jan', 'joe', 'trois'].each do |pid|
        fpath = File.join(@dosext, "full_brin_#{pid}.html")
        expect(File.exist? fpath).to eq true
      end
    end
    it 'n’extrait pas le brin de quatre' do
      fpath = File.join(@dosext, "full_brin_quatre.html")
      expect(File.exist? fpath).to eq false
    end
  end
end
