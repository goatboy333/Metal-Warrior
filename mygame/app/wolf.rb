class Wolf
  attr_sprite
  attr_reader  :max_health
  attr_accessor :health

  def initialize(x,y)
    @max_health = 100
    @health = 100
    @x = x
    @y = y
    @w = 50 * 3
    @h = 32 * 3
    @path = 'sprites/enemies/wolf.png'
    @source_x = 56
    @source_y = 0
    @source_w = 56
    @source_h = 32
  end

  def hit(damage)
    @health -= damage
  end
end
