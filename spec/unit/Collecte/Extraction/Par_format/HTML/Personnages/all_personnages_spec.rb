describe 'La commande :all_personnages_html' do
  before(:all) do
    parse_collecte(folder_test_5)
    @dosext = File.join(folder_test_5,'extraction')
    FileUtils.rm_rf @dosext if File.exist? @dosext
    expect(File.exist? @dosext).to eq false
    # ===> TEST <===
    collecte.extract(:all_personnages_html)
  end
  let(:code) { @code }

  # Retourne le path du fichier brin du personnage
  def file_for_perso pid
    File.join(@dosext, "full_brin_#{pid}.html")
  end

  # Retourne l'inverse de +liste+
  def anti_scenes_de liste
    [1,2,3,4,5,6,7,8].reject{|i|liste.include?i}
  end

  describe 'Prérequis : les données des personnages' do
    personnages_folder_5.each do |pid, pdata|
      it "correspondent pour ##{pid}" do
        expect(film.personnages[pid].scenes_ids).to eq pdata[:scenes_ids]
      end
    end
  end

  personnages_folder_5.each do |pid, pdata|
    describe "Le fichier du personnage ##{pid}" do
      it 'existe' do
        expect(File.exist? file_for_perso(pid)).to eq true
      end
      it 'contient les bonnes scènes' do
        scenes_ids = pdata[:scenes_ids]
        code = File.read(file_for_perso pid)
        scenes_ids.each do |sid|
          expect(code).to have_tag("div#scene-#{sid}")
        end
      end
      it 'ne contient pas les mauvaises scènes' do
        code = File.read(file_for_perso pid)
        anti_scenes_de(pdata[:scenes_ids]).each do |sid|
          expect(code).not_to have_tag("div#scene-#{sid}")
        end
      end
    end
  end
end
