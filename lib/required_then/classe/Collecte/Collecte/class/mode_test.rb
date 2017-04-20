class Collecte
class << self

  def mode_test?
    if @is_mode_test === nil
      @is_mode_test = File.exist?(path_mode_test)
    end
    @is_mode_test
  end
  alias :test? :mode_test?

  def set_mode_test on
    if on
      File.open(path_mode_test,'wb'){|f| f.write "#{Time.now.to_i}"}
    else
      File.exist?(path_mode_test) && File.unlink(path_mode_test)
    end
    @is_mode_test = on
  end

  def path_mode_test
    @path_mode_test ||= File.join(MAIN_FOLDER, '.MODETEST')
  end
end #/<< self
end #/Collecte
