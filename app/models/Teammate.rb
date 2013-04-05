# encoding: utf-8

class Teammate
  attr_accessor :display_name, :selected
  attr_writer :spoken_name

  def initialize(display_name, spoken_name = nil)
    self.display_name = display_name
    self.spoken_name = spoken_name
    self.selected = true
  end

  def spoken_name
    @spoken_name || display_name
  end

  def toggle_selected
    self.selected = !self.selected
  end

  All = [
    Teammate.new("JCO", "Joel"),
    Teammate.new("SAM", "Stéphan"),
    Teammate.new("AVE", "Aurélien")
  ]
end
