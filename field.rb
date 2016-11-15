class Field

  attr_accessor :map, :width, :height

  def initialize
    self.width = 10
    self.height = 10
    self.map = Array.new(self.width) { Array.new(self.height, 0) }
  end

  def print
    map.each{|arr| p arr}
  end

end
