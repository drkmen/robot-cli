class Field
  attr_accessor :map, :width, :height

  def initialize
    self.width = 10
    self.height = 10
    self.map = Array.new(self.width) { Array.new(self.height, 0) }
  end

  def draw
    map.each do |arr|
      p arr.join(' ')
    end
  end
end
