class Player
  attr_sprite
  attr_reader :action, :max_health
  attr_accessor :health

  def initialize(x, y)
    @max_health = 100
    @health = 100
    @x = x
    @y = y
    @w = 47 * 2.5
    @h = 42 * 2.5
    # @path = 'sprites/villager/Run/villager_run.png'
    # @path ='/sprites/bladekeeper/spritesheets/metal_bladekeeper_FREE_v1.1_SpriteSheet_288x128.png'
    @path ='/sprites/bladekeeper/mog/idlesheet.png'
    @source_w = 47
    @source_h = 42
    @action = {idle: 0 * @source_h,
               run: 14 * @source_h,
               jump: 11 * @source_h,
               attack: 6 * @source_h,
               die: 0 * @source_h}
    @source_x = 0
    @source_y = @action[:idle]
  end
end
