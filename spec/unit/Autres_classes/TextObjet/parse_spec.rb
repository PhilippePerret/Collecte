describe 'Parse des textes-objets' do
  before(:all) do
    Collecte.new
  end

  let(:film)  { @film ||= Film.new }
  let(:fto)   { @fto  ||= Film::TextObjet.new(film) }

  describe '#parse' do
    it 'répond' do
      expect(fto).to respond_to :parse
    end

    context 'sans argument' do
      it 'produit une erreur' do
        expect{fto.parse}.to raise_error StandardError
      end
    end

    context 'avec un texte simple' do
      before(:all) do
        @film = Film.new
        @fto  = Film::TextObjet.new(@film)
        @fto.parse "Un simple texte."
      end
      it 'définit @raw' do
        expect(fto.raw).to eq 'Un simple texte.'
      end
      it 'ne définit par d’horloge' do
        expect(fto.horloge).to eq nil
      end
    end

    context 'avec un texte et horloge' do
      before(:all) do
        @film = Film.new
        @fto = Film::TextObjet.new(@film)
        @fto.parse "0:12:23 Un texte horlogé."
      end
      it 'met le string dans @raw' do
        expect(fto.raw).to eq '0:12:23 Un texte horlogé.'
      end
      describe 'L’horloge' do
        it 'est définit' do
          expect(fto.horloge).not_to eq nil
        end
        it 'contient la bonne horloge' do
          expect(fto.horloge.horloge).to eq '0:12:23'
        end
        it 'contient le bon temps' do
          expect(fto.horloge.time).to eq 12*60+23
        end
        it 'ne définit pas de durée' do
          expect(fto.horloge.duree).to eq nil
        end
      end
    end
    # context avec horloge

    context 'avec un texte et une note' do
      before(:all) do
        @film = Film.new
        @fto = Film::TextObjet.new(@film)
        @fto.parse "Un texte annoté. (12)"
      end
      it 'met le string dans @raw' do
        expect(fto.raw).to eq 'Un texte annoté. (12)'
      end
      it 'renseigne @notes_ids' do
        expect(fto.notes_ids).to eq [12]
      end
    end
    # / Texte et note

    context 'avec un texte et des personnages' do
      before(:all) do
        @film = Film.new
        @fto = Film::TextObjet.new(@film)
        @fto.parse "[PERSO#joe] rentre avec [PERSO#jan]."
      end
      it 'met le string dans @raw' do
        expect(fto.raw).to eq '[PERSO#joe] rentre avec [PERSO#jan].'
      end
      it 'définit la liste des personnages' do
        expect(fto.personnages_ids).to eq ['joe', 'jan']
      end

    end
    # /Texte et personnages

    context 'avec un texte lié à un brin' do
      before(:all) do
        @film = Film.new
        @fto  = Film::TextObjet.new(@film)
        @fto.parse "Un texte appartenant à un brin. b12 b14"
      end
      it 'met le string dans @raw' do
        expect(fto.raw).to eq 'Un texte appartenant à un brin. b12 b14'
      end
      it 'la méthode #to_str retourne seulement le texte' do
        expect(fto.to_str).to eq 'Un texte appartenant à un brin.'
      end
      it 'définit @brins_ids' do
        expect(fto.brins_ids).to eq [12, 14]
      end
    end

    context 'avec un texte qui contient tout' do
      before(:all) do
        @film = Film.new
        @fto  = Film::TextObjet.new(@film)
        @fto.parse "1:23:56 [PERSO#joe] rentre avec [PERSO#jan]. b12 b14 (24)(13)"
      end
      it 'met le string dans @raw' do
        expect(fto.raw).to eq '1:23:56 [PERSO#joe] rentre avec [PERSO#jan]. b12 b14 (24)(13)'
      end
      it '#to_str ne retourne que le texte' do
        expect(fto.to_str).to eq '[PERSO#joe] rentre avec [PERSO#jan].'
      end
      it 'définit l’horloge' do
        hor = fto.horloge
        expect(hor).not_to eq nil
        expect(hor).to be_instance_of Film::Horloge
        expect(hor.horloge).to eq '1:23:56'
        expect(hor.time).to eq 3600+23*60+56
      end
    end
  end
  #/ #parse
end
