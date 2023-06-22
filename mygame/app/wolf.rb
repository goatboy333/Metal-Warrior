class Wolf
  attr_sprite
  attr_reader  :max_health, :action
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
    #@source_y = 0
    
    @source_w = 56
    @source_h = 32
    @flip_horizontally = false
    @action = {idle: {width: 56, sprite_sheet_height: 0 * @source_h},
               run: {width: 56, sprite_sheet_height: 0 * @source_h} ,
               attack: {width: 56, sprite_sheet_height: 0 * @source_h}} 
    @source_y = @action[:idle][:sprite_sheet_height]
  end

  def hit(damage)
    @health -= damage
  end

  def follow_player(player_x, player_w)
    if @x > player_x + ((player_w / 2) + 30)
      @x -= 5 #speed
      @flip_horizontally = false
    elsif @x < player_x + ((player_w / 2) - 200)
      @x += 5
      @flip_horizontally = true
    #else
    #  @x = @x
    end
  end
end
