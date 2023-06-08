class Rat
  attr_sprite

  def initialize(x,y)
    @x = x
    @y = y
    @w = 71 * 1
    @h = 58 * 1
    @path = 'sprites/rat/rat-charset.png'
    @source_x = 0
    @source_y = 100
    @source_w = 71
    @source_h = 58
  end
end
