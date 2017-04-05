# encoding: UTF-8
class Collecte

  def add_error err
    @errors ||= Array.new
    @errors << err
  end

  def show_errors
    @errors != nil || return
    puts @errors.join(RC)
  end

end #/Collect
