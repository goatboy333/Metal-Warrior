# require 'app/debug.rb'
require 'app/backgrounds.rb'
# require 'app/creature.rb'
# require 'app/rat.rb'
# require 'app/eagle.rb'
# require 'app/bear.rb'
# require 'app/wolf.rb'
# require 'app/player.rb'
# require 'app/spear.rb'

class MyGame
  attr_gtk
  attr_reader :player, :wolf

  def initialize(args)
    @player = Player.new(args.grid.w / 4, 50)
    @wolf    = Wolf.new(args.grid.w - 200, 50)
    @jump_timer=0
    @attack_timer=0
    @hit = false # temporary hit tracker to avoid multiple hits
  end

  def calc_animation(obj,how_many,long,repeat)
    start_animation_on_tick = 0
    sprite_index = start_animation_on_tick.frame_index how_many, long, repeat
    obj.source_x = obj.source_w * sprite_index
  end

  def tick
    handle_input

    player_rect = {x: player.x + (player.w / 2), y: player.y, w: 60, h: 50} # Select just the player, no transparency

    if @jump_timer > 0
      calc_animation(player,20,5,true)
      @jump_timer -= 1

      if @jump_timer > 30
        player.source_y = player.source_y - 2
      else
        player.source_y = player.source_y + 2
      end

      if player.flip_horizontally
        player.source_x = player.source_x + 2
      else
        player.source_x = player.source_x - 2
      end

    elsif @attack_timer > 0
      @attack_timer -= 1
      calc_animation(player,8,3,true)

      if args.geometry.intersect_rect?(player_rect, wolf) 
        
        if @hit == false
          wolf.hit(20)
          puts "HIT"
          puts wolf.health
          @hit = true  
        end

        if @hit == true && @attack_timer - 1 < 0
          @hit = false
        end

      else
          
        puts "NOT HIT"
        @hit = false
      end

    else
      calc_animation(player,8,3,true)
    end

    calc_animation(wolf,4,5,true)

    render
  end

  def handle_input
    if keyboard.up && @jump_timer == 0
      @jump_timer = 60
      player.source_y = player.action[:jump]
    end

    if keyboard.space
      @attack_timer = 60
      player.source_y = player.action[:attack]
    end

    if @jump_timer == 0 && @attack_timer == 0
      if keyboard.left
        player.x -= 10
        player.flip_horizontally = true
        player.source_y = player.action[:run]
      elsif keyboard.right
        player.x += 10
        player.flip_horizontally = false
        player.source_y = player.action[:run]
        # elsif keyboard.down
        #   player.y -= 10
        #   player.source_y = player.action[:run]
      elsif keyboard.space
        player.source_y = player.action[:attack]
      elsif @jump_timer == 0
        player.source_y = player.action[:idle]
      end
    end
  end

  def render
    [player,wolf].each do |sprite|
      outputs.sprites << sprite if sprite.health > 0
      outputs.borders << {x: sprite.x + (sprite.w / 2), y: sprite.h + 30, w: 50, h: 10} if sprite.health > 0
      outputs.solids << {x: sprite.x + (sprite.w / 2), y: sprite.h + 30, w: 50 * (sprite.health / sprite.max_health), h: 10, r: 255, g: 255, b:0, a: 255} if sprite.health > 0
    end
  end
end

class Player
  attr_sprite
  attr_reader :action, :max_health
  attr_accessor :health

  def initialize(x, y)
    @max_health = 100
    @health = 100
    @x = x
    @y = y
    @w = 288 * 2.5
    @h = 128 * 2.5
    # @path = 'sprites/villager/Run/villager_run.png'
    @path ='/sprites/bladekeeper/spritesheets/metal_bladekeeper_FREE_v1.1_SpriteSheet_288x128.png'
    @source_w = 288
    @source_h = 128
    @action = {idle: 15 * @source_h,
               run: 14 * @source_h,
               jump: 11 * @source_h,
               attack: 5 * @source_h,
               die: 0 * @source_h}
    @source_x = 0
    @source_y = @action[:idle]
  end

end

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

def tick args
  #$my_game.background args
  #$my_game.middleground args
  #$my_game.foreground args

  $my_game ||= MyGame.new(args)
  $my_game.args = args
  $my_game.tick
end

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

# def tick args
#   #$my_game.background args
#   #$my_game.middleground args
#   #$my_game.foreground args

#   $my_game ||= MyGame.new(args)
#   $my_game.args = args
#   $my_game.tick
# end


# def tick(args)
#   initialize_game args
#   #music_background args
#   middleground(args)
#   foreground args
#   @player.animate(args)
#   @rat.animate(args)
#   @wolf.animate(args)  #why are these instance variables?
#   @bear.animate(args)
#   @eagle.animate(args)
#   @player.check_keyboard(args)
#   display_spear(args)
# end

# def initialize_game(args)
#   args.gtk.hide_cursor
#   args.state.player.x ||= 250
#   args.state.player.y ||= 50
#   args.state.player.jump ||= false
#   args.state.player.base ||= 50
#   args.state.player.speed = 10
#   args.state.player.direction ||= -1
#   args.state.enemies ||= [{x: 1200, y: 50, direction: 1}]
#   args.state.spear.active ||= false
#   args.state.spear.direction ||= -1
#   args.state.screenWidth ||= 1280
#   args.state.trigger_sample ||= 0
#   args.state.backgroundX ||= -10
#   args.state.backgroundY ||= 0
#   args.state.groundX ||= 0
#   args.state.groundStartPosX ||= 0

#   @player ||= Player.new(args)
#   @rat ||= Rat.new(args)
#   @eagle ||= Eagle.new(args)
#   @bear ||= Bear.new(args)
#   @wolf ||= Wolf.new(args)

#   [@rat,@eagle,@bear,@wolf].each do |enemy|
#     args.state.enemies << enemy
#   end

#   args.state.weapon_spears ||= []  # array to record the spear instanciations

#   args.state.current_time ||= 0 # Record current time
#   args.state.previous_time ||= 0 # record the time at the end of a function to compare to current time
# end

# def display_spear(args)
#   args.state.weapon_spears.each do |spear|
#     spear.hit(args)
#     spear.display(args)
#     spear.move(args)
#   end
# end

# def music_background args
#   args.outputs.sounds << 'sounds/forest.ogg'
# end
