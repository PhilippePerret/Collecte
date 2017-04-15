describe 'Points structurels d’une scène' do
  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }
  let(:scene_un) { @scene_un ||= film.scenes.first }
  let(:scene_deux) { @scene_deux ||= film.scenes[2] }
  let(:scene_trois) { @scene_trois ||= film.scenes[3] }
  before(:all) do
    @collecte = Collecte.new(folder_test_1)
    @collecte.parse
  end

  describe 'la deuxième scène sans point structurel' do
    it 'retourne nil pour :stt_points_ids' do
      expect(scene_deux.stt_points_ids).to eq nil
    end
    it 'retourne nil pour :points_structurels' do
      expect(scene_deux.points_structurels).to eq nil
    end
  end


  describe 'la première scène avec point structurel' do
    it 'ne retourne pas nil pour :stt_points_ids' do
      expect(scene_un.stt_points_ids).to eq [:inc_pert, :inc_dec]
    end
    it 'retourne les points structurels avec :points_structurels' do
      expect(scene_un).to respond_to :points_structurels
      ps = scene_un.points_structurels
      expect(ps).to be_instance_of Array
      expect(ps.first).to be_instance_of Film::Structure::Point
    end
    describe 'L’incident déclencheur de la première scène' do
      let(:inc_dec) { @inc_dec ||= scene_un.points_structurels[1] }
      it 'possède le bon début id' do
        expect(inc_dec.id).to eq :inc_dec
      end
      it 'possède les bonnes données absolues' do
        d = inc_dec.abs_data
        expect(d).not_to eq nil
        expect(d).to be_instance_of Hash
        expect(d[:coefpos]).to eq nil
      end
      it 'existe' do
        expect(inc_dec).to be_exist
      end
      it 'possède les temps de début et de fin de la scène' do
        expect(inc_dec.debut).to eq 0
        expect(inc_dec.fin).to eq 70
      end
      it 'possède une zone absolue avec début à 0 (défini par coef_before)' do
        expect(inc_dec.zone_pfa).to be_instance_of Film::Zone
        expect(inc_dec.zone_pfa.debut).to eq 0
      end
      it 'possède une zone absolue avec fin à un quart' do
        expect(inc_dec.zone_pfa.fin).to eq 50
      end
      it 'possède une zone absolue avec position idéal au milieu de l’exposition' do
        expect(inc_dec.zone_pfa.position).to eq 25
      end
      it 'in_zone? retourne nil' do
        expect(inc_dec.in_zone?).to eq true
      end
      it 'possède la bonne zone relative' do
        expect(inc_dec.zone_relative).to be_instance_of Film::Zone
      end

    end
  end

  describe 'La troisième scène avec point structurel positionné' do
    let(:denouement) { @denouement ||= scene_trois.points_structurels.first }
    it 'possède le point structurel :denouement' do
      expect(scene_trois.stt_points_ids).to eq [:denouement]
    end
    it 'le point structurel possède une zone pfa' do
      expect(denouement.zone_pfa).not_to eq nil
    end
    it 'la zone PFA possède le bon début' do
      # puts "Durée du film : #{film.duree}"
      # puts "Position dénouement : #{(0.75 * film.duree).to_i}"
      expect(denouement.zone_pfa.debut).to eq 146
    end
    it 'la zone PFA possède la bonne fin' do
      expect(denouement.zone_pfa.fin).to eq 154
      # Rappel : il s'agit du point exact du passage au
      # dénouement, pas du dénouement en entier
    end
    it 'la zone PFA possède la bonne position (exacte)' do
      expect(denouement.zone_pfa.position).to eq 150
    end
    it 'la zone relative possède le bon début' do
      expect(denouement.zone_relative.debut).to eq 170
    end
    it 'la zone relative possède la bonne fin' do
      expect(denouement.zone_relative.fin).to eq 200
    end
    it 'le point n’est pas in_zone (in_zone? est false)' do
      expect(denouement).not_to be_in_zone
    end
    it 'le point est out_zone (out_zone? est true)' do
      expect(denouement).to be_out_zone
    end
    it 'le décalage (offset)' do
      expect(denouement.offset).to eq 16
    end
  end
end
