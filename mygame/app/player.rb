class Player
  attr_sprite
  attr_reader :action, :max_health
  attr_accessor :health

  def initialize(x, y)
    @max_health = 100
    @health = 100
    @x = x
    @y = y
    @w = @source_w * 2.5
    @h = 48 * 2.5
    # @path = 'sprites/villager/Run/villager_run.png'
    # @path ='/sprites/bladekeeper/spritesheets/metal_bladekeeper_FREE_v1.1_SpriteSheet_288x128.png'
    @path ='/sprites/bladekeeper/trimmed/idlerunattk.png'
    @source_w = 56
    @source_h = 48
    @action = {idle: {width: 56, sprite_sheet_height: 0 * @source_h},
               run: {width: 60, sprite_sheet_height: 1 * @source_h} ,
               attack: {width: 100, sprite_sheet_height: 2 * @source_h}} 
               #,
               #jump: 11 * @source_h,
               #die: 4 * @source_h}
    @source_x = 0
    @source_y = @action[:idle][:sprite_sheet_height]
  end

  def hit(damage)
    @health -= 0 #damage
  end
end
