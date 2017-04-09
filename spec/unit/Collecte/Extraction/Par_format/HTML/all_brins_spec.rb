describe 'Extraction HTML de tous les brins' do
  let(:collecte) { @collecte }
  let(:extracteur) { @extracteur }
  let(:code) { @code }
  let(:dossier_extraction) { @dossier_extraction ||= extracteur.final_file.folder }
  describe 'l’argument :all_brins_html dans #extract' do
    before(:all) do
      @collecte = Collecte.new(folder_test_4)
      @extracteur = @collecte.extractor(:html)
    end
    it 'ne produit pas d’erreur' do
      expect{collecte.extract(:all_brins_html)}.not_to raise_error
    end
    it 'produit tous les fichiers brins' do
      FileUtils.rm_rf(dossier_extraction) if File.exist?(dossier_extraction)
      collecte.extract(:all_brins_html)
      expect(File.exist?(dossier_extraction)).to eq true
      (1..6).each do |bid|
        expect(File.exist?(File.join(dossier_extraction,"brin_#{bid}.html"))).to eq true
      end
    end
    it 'chaque fichier brin contient bien ses scènes' do
      {
        1 => [1,2,3,4,5],
        2 => [2,4,7],
        3 => [3,4,5],
        4 => [4],
        5 => [],
        6 => [4]
      }.each do |brin_id, scenes_in|
        scenes_out = (1..7).reject{|i| scenes_in.include?(i)}
        path = File.join(dossier_extraction,"brin_#{brin_id}.html")
        code = File.read(path)
        if scenes_in.count > 0
          expect(code).to have_tag('section#sequencier.scenes')do
            scenes_in.each do |sid|
              with_tag("div#scene-#{sid}")
            end
            scenes_out.each do |sid|
              without_tag("div#scene-#{sid}")
            end
          end
        else
          expect(code).not_to have_tag('section#sequencier')
        end
      end
    end
  end
end
