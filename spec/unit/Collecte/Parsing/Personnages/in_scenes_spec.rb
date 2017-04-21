describe 'Scenes des personnages' do
  before(:all) do
    parse_collecte(folder_test_5)
  end
  it 'le parse définit les scènes du personnage' do
    personnages_folder_5.each do |pid, pdata|
      expect(film.personnages[pid].scenes_ids).to eq pdata[:scenes_ids]
    end
  end
  it 'scenes renvoie les instances Film::Scene des scènes du personnage' do
    personnages_folder_5.each do |pid, pdata|
      scenes = film.personnages[pid].scenes
      expect(scenes.count).to eq pdata[:scenes_ids].count
      scenes.each do |scene|
        expect(pdata[:scenes_ids]).to include scene.id
        # La scène doit contenir le personnage
        expect(scene.personnages_ids).to include pid
      end
    end
  end
end
