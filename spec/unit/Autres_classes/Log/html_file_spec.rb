describe 'Fichier HTML en sortie' do
  before(:all) do
    # Il faut obligatoirement une collecte pour que
    # le log sache où enregistrer le fichier.
    @collecte = Collecte.new(folder_test_1)
  end

  let(:hfile) { @hfile ||= Log.html_file }

  it 'est une instance HTMLFile' do
    expect(Log.html_file).to be_instance_of HTMLFile
  end
  it 'répond à save' do
    expect(hfile).to respond_to :save
  end
  it 'répond à open' do
    expect(hfile).to respond_to :open
  end

  context 'avec des messages log' do
    before(:all) do
      log "Un premier message"
      log "Un deuxième message"
      log "Une première erreur", error: true
      log "Une deuxième erreur", error: true
    end
    let(:html_log_path) { @htmllogpath ||= File.join(folder_test_1, 'log.html') }
    it 'la méthode `Log#build` construit le fichier log.html' do
      File.unlink(html_log_path) if File.exist?(html_log_path)
      expect(File.exist? html_log_path).to eq false
      Log.build
      expect(File.exist? html_log_path).to eq true
      # Débug : pour voir l'affichage du fichier
      # Log.html_file.open
    end
    it 'le fichier contient le bon code' do
      File.exist?(html_log_path) || Log.build
      code = File.read(html_log_path)
      expect(code).to have_tag('h3', text: 'Erreurs survenues')
      expect(code).to have_tag('div.error', text: /### ERREUR : Une première erreur/)
      expect(code).to have_tag('div.error', text: /### ERREUR : Une deuxième erreur/)
      expect(code).to include "Un premier message"
      expect(code).to include "Un deuxième message"
    end
  end

end
