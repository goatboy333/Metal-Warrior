# require 'app/debug.rb'
require 'app/backgrounds.rb'
# require 'app/creature.rb'
require 'app/rat.rb'
# require 'app/eagle.rb'
# require 'app/bear.rb'
require 'app/wolf.rb'
require 'app/player.rb'
# require 'app/spear.rb'

class MyGame
  attr_gtk
  attr_reader :player

  def initialize(args)
    @player = Player.new(args.grid.w / 4, 50)

    @wolf    = Wolf.new(args.grid.w - 200, 50)
    @wolves = [@wolf]
    @wolf_attack_timer = 18

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

    @wolves.each do |wolf|
      wolf.follow_player(player.x, player.w)
    end

    player_rect = {x: player.x, y: player.y, w: player.w, h: player.h} # Select just the player, no transparency
    unless player.health <= 0

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
        calc_animation(player,6,3,true)

        @wolves.each do |wolf|
          if args.geometry.intersect_rect?(player_rect, wolf) &&
              wolf.health > 0 && player.health > 0

            if @hit == false
              wolf.hit(20)
              puts "HIT"
              puts wolf.health
              @hit = true
            end

            if @hit == true && @attack_timer <= 0
              @hit = false
            end

          else

            puts "NOT HIT"
            @hit = false
          end
        end

      elsif @wolf_attack_timer <= 0
        @wolf_attack_timer = 0

      end

      if args.geometry.intersect_rect?(player_rect, @wolf) && @attack_timer <= 0 &&
          @wolf_attack_timer > 0 && @wolf.health > 0 && player.health > 0

        player.hit(2)
        puts "PLAYER HIT"
        puts player.health
        @wolf_attack_timer = 18 if @wolf_attack_timer <= 0

      end
      calc_animation(player,6,3,true)
      calc_animation(@wolf,4,5,true)
    end

    render
  end

  def handle_input
    if keyboard.up && @jump_timer == 0
      @jump_timer = 60
      player.source_y = player.action[:jump]
    end

    if (keyboard.space || keyboard.control) and @attack_timer <= 0
      @attack_timer = 18
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
      elsif @jump_timer == 0
        player.source_y = player.action[:idle]
      end
    end
  end

  def render

    if player.health <= 0
      outputs.labels << {x: 400, y: 400, text: "YOU'RE DEAD!", r: 255, size_enum: 40}
    else

      [player,@wolf].each do |sprite|
        outputs.sprites << sprite if sprite.health > 0
        outputs.borders << sprite
        outputs.borders << {x: sprite.x + (sprite.w / 3), y: sprite.y + (sprite.h + 10), w: 50, h: 10} if sprite.health > 0
        outputs.primitives << {x: sprite.x + (sprite.w / 3), y: sprite.y + (sprite.h + 10), w: 50 * (sprite.health / sprite.max_health), h: 10, r: 255, g: 255, b:0, a: 255}.solid if sprite.health > 0
      end
    end
  end
end

def tick args
  $my_game.background args
  $my_game.middleground args
  $my_game.foreground args

  $my_game ||= MyGame.new(args)
  $my_game.args = args
  $my_game.tick
end
