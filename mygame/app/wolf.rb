class Wolf
  attr_sprite
  attr_reader  :max_health, :action
  attr_accessor :health, :is_hit, :timeout

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
    @r = 255
    @g = 255
    @b = 255
    @source_w = 56
    @source_h = 32
    @flip_horizontally = false

    @action = {idle: {width: 56, sprite_sheet_height: 0 * @source_h},
               run: {width: 56, sprite_sheet_height: 0 * @source_h} ,
               attack: {width: 56, sprite_sheet_height: 0 * @source_h}} 
    @source_y = @action[:idle][:sprite_sheet_height]

    @timeout = 0
    @is_hit = false

  end

  def hit(damage)
    @health -= damage
    @r = 255
    @g = 0
    @b = 0
  end

  def reset_wolf_color()
    @r = 255
    @g = 255
    @b = 255
  end

  def dead()
    @flip_vertically = true
    @a = 50
  end

  def follow_player(player_x, player_w)
    if @health > 0
    if (@x + @w) > player_x and (@x + @w) < (player_x + player_w) and @flip_horizontally = true
      @x = player_x 

    elsif @x > player_x and @x < (player_x + player_w) and @flip_horizontally = false
      @x = player_x + player_w

    elsif @x > player_x + (player_w)
        @x -= 5 #speed
        @flip_horizontally = false
    else @x < player_x
        @x += 5
        @flip_horizontally = true
      
        #else
        #  @x = @x
      end
    end
  end
end
