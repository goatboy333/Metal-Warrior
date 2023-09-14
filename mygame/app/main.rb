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
    @wolves = [ Wolf.new(args.grid.w - 200, 50) ]
    @game_start = false
    @wolf_attack_timer = 18
    @jump_timer=0
    @attack_timer=0
    @lightning_timer=0

    @game_ending_timer=60
    @splash_length_second = 0
    @wolves_x_array = []
    @dead_wolves = 0
    @dead_wolves_counter = 0
    @previous_dead_wolves_count = 0

    @game_end = false
    @game_timer = Time.now
    @game_length_seconds = nil

    # contents = args.gtk.read_file "config"
    # @sound = contents.split("\n").first

  end

  def calc_animation(obj,how_many,long,repeat)
    start_animation_on_tick = 0
    sprite_index = start_animation_on_tick.frame_index how_many, long, repeat
    obj.source_x = obj.source_w * sprite_index
  end

  def tick


    if @game_end
      if @player.health <= 0
        # loser
        # Display 'you suck'
      else
        winner_ending args
      end # health > 0
    elsif @game_start == false # Splash screen
      splash_screen args
    else  # Game starts here
      # keep player
      background args
      middleground args
      foreground args

      #args.outputs.sounds << "sounds/surprise-impact.ogg" #unless @sound == "sound=false"

      if @lightning_timer <= 0

        if (args.state.tick_count / 60) % Math.rand(8) == 0
          direction = Math.rand(2)

          if direction == 0
            @wolves << Wolf.new(0,50)
          else
            @wolves << Wolf.new(args.grid.w - 200,50)
          end
        end
      end

      dead_wolves_counter

      if (@dead_wolves_counter - @previous_dead_wolves_count >= 5)
        outputs.sprites << {x: player.x + (player.w / 3), y: player.y + (player.h + 10), w: 80, h: 80,
                            path: 'sprites/lightning_icon.png', source_h: 500, source_w: 500, source_x: 0, source_y: 0,}
      end

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
          # object, frames, length, repeat
          player.action_sprite_dimension(:attack)
          calc_animation(player,6,3,true)

          if player.flip_horizontally == false
            @wolves_shortlist = @wolves.select { |wolf|
              if wolf.x >= (player.x)
                true
              else
                false
              end
            }

          elsif player.flip_horizontally == true
            @wolves_shortlist = @wolves.select { |wolf|
              if (wolf.x + wolf.w) <= (player.x + player.w)
                true
              else
                false
              end
            }
          end

          @wolves_shortlist.each do |wolf|
            if args.geometry.intersect_rect?(player_rect, wolf) &&
                wolf.health > 0 && player.health > 0

              if wolf.is_hit == false
                wolf.hit(40)
                args.outputs.sounds << "sounds/wolfbark.wav"  unless args.state.mute
                # puts "HIT"
                # puts wolf.health
                wolf.is_hit = true
              end

              if wolf.is_hit == true && @attack_timer <= 0
                wolf.is_hit = false
                wolf.reset_wolf_color()
              end

            else

              # puts "NOT HIT"
              wolf.is_hit = false
            end
          end

        elsif @wolf_attack_timer <= 0
          @wolf_attack_timer = 0

        elsif @lightning_timer > 0
          trigger_lightning

        elsif @lightning_timer <= 0
          @lightning_timer = 0
          @wolves_x_array.clear
          calc_animation(player,6,3,true)

        else
          calc_animation(player,6,3,true)
        end


        @wolves.each do |wolf|
          if wolf.stunned == 0
            if args.geometry.intersect_rect?(player_rect, wolf) && @attack_timer <= 0 &&
                @wolf_attack_timer > 0 && wolf.health > 0 && player.health > 0

              player.hit(2)
              #puts "PLAYER HIT"
              #puts player.health
              @wolf_attack_timer = 18 if @wolf_attack_timer <= 0
            end
          end

          if wolf.stunned > 0
              wolf.stunned -= 1
          end

          unless wolf.health <= 0
            if wolf.stunned == 0
              calc_animation(wolf,4,5,true)
            elsif
              calc_animation(wolf,1,5,true)
            end
          end
        end
      end

    end # game end
    render
  end

  def handle_input
    # if keyboard.up && @jump_timer == 0
    #   @jump_timer = 60
    #   player.source_y = player.action[:jump]
    # end

    if @game_start == false and keyboard.space
      args.audio[:music] = {
        input: 'sounds/surprise-impact.ogg',
        gain: 0.1,
        looping: true
      }

      @game_start = true
      @game_length_seconds = 60
      @splash_length_second = args.state.tick_count
    end

    if keyboard.key_down.m
      if args.state.mute
        args.audio[:music].paused = false
        args.state.mute = false
      else
        args.audio[:music].paused = true
        args.state.mute = true
      end
    elsif keyboard.key_down.period
        args.audio[:music].gain += 0.1
    elsif keyboard.key_down.comma
        args.audio[:music].gain -= 0.1
    end

    if @player.health <= 0 and keyboard.enter
      $gtk.reset
      initialize(args)

    elsif (keyboard.space || keyboard.control) and @attack_timer <= 0
      @attack_timer = 18
      player.action_sprite_dimension(:attack)
      args.outputs.sounds << "sounds/sword.wav" unless args.state.mute
    end

    if (keyboard.alt) and @lightning_timer <= 0 and (@dead_wolves_counter - @previous_dead_wolves_count >= 5)
      @lightning_timer = 30
      @previous_dead_wolves_count = @dead_wolves_counter
      args.outputs.sounds << "sounds/thunder.wav" unless args.state.mute
      #trigger_lightning()

    end

    if @jump_timer == 0 && @attack_timer == 0 && @game_end != true && @game_start
      if keyboard.left
        player.x -= 10
        player.flip_horizontally = true
        player.action_sprite_dimension(:run)
        if player.x <= (grid.left + 10)
          player.x = (grid.left + 10)
        end

      elsif keyboard.right
        player.x += 10
        player.flip_horizontally = false
        player.action_sprite_dimension(:run)
        if (player.x + player.w) >= (grid.right - 10)
          player.x = ((grid.right - player.w) - 10)
        end
        # elsif keyboard.down
        #   player.y -= 10
        #   player.source_y = player.action[:run]
      elsif @jump_timer == 0
        player.action_sprite_dimension(:idle)
      end
    end
  end

  def render

    if @game_start
      if @player.health <= 0
        time_left = @game_length_seconds
      else
        time_left = @game_length_seconds - ((args.state.tick_count - @splash_length_second )/ 60).to_i
        time_left = 0 if time_left < 0
      end

      outputs.labels << {x: 1000, y: 700, text: "TIME LEFT : " + time_left.to_s, r: 255, g: 255, size_enum: 5}
    end
    # outputs.labels << {x: 1000, y: 650, text: "DEAD ENEMIES : " + @dead_wolves_counter.to_s, r: 255, g: 255, size_enum: 5}
    # outputs.labels << {x: 1000, y: 600, text: "P DEAD ENEMIES : " + @previous_dead_wolves_count.to_s, r: 255, g: 255, size_enum: 5}

    if player.health <= 0
      outputs.labels << {x: 400, y: 500, text: "YOU'RE DEAD!", r: 255, size_enum: 40}
      outputs.labels << {x: 380, y: 350, text: "PRESS ENTER TO RETRY", r: 255, size_enum: 20}
    elsif (((args.state.tick_count - @splash_length_second ) / 60).to_i) == @game_length_seconds or @game_end
      outputs.labels << {x: 120, y: 500, text: "YOU FOUGHT A GLORIOUS BATTLE", r: 255, size_enum: 30}
      outputs.labels << {x: 350, y: 350, text: "WELCOME TO WALHALLA", r: 255, size_enum: 20}

      outputs.sprites << player
      @game_end = true

    else

      creatures = [player] + @wolves

      creatures.each do |sprite|
        sprite.dead if sprite.health <= 0
        outputs.sprites << sprite
        # outputs.borders << sprite
        # outputs.borders << {x: sprite.x + (sprite.w / 3), y: sprite.y + (sprite.h + 10), w: 50, h: 10} if sprite.health > 0
        outputs.primitives << {x: sprite.x + (sprite.w / 3), y: sprite.y + (sprite.h + 10), w: 50 * (sprite.health / sprite.max_health), h: 10, r: 255, g: 255, b:0, a: 255}.solid if sprite.health > 0
      end
    end
  end
end

def trigger_lightning()

  @lightning_timer -= 1
  lightning_source_x = 0
  sprite_index1 = 0


  @wolves.each do |wolf_health|
    if (wolf_health.health > 0)
      @wolves_x_array << wolf_health.x
      wolf_health.health = -1
      #puts @wolves_x_array
    end
  end

  @wolves_x_array.each do |wolf|
    start_animation_on_tick1 = 0
    sprite_index1 = start_animation_on_tick1.frame_index(4, 3, true)
    lightning_source_x = 700 * sprite_index1
    outputs.sprites << {x: wolf - 280, y: 10, w: 700, h: 700, path: 'sprites/lightningbolt.png', source_h: 700, source_w: 700, source_x: lightning_source_x, source_y: 0,}
  end

end

def dead_wolves_counter
  @wolves.each do |wolves|
    if wolves.health <= 0
      @dead_wolves += 1
    end
  end

  #puts @dead_wolves
  @dead_wolves_counter = @dead_wolves
  @dead_wolves = 0
end

def tick args

  $my_game ||= MyGame.new(args)
  $my_game.args = args
  $my_game.tick
end

 def splash_screen args
  handle_input

  args.outputs.sprites << [0, 0, 1280, 720, 'sprites/background/gabriel-tovar--dfqaTOIFVA-unsplash.jpg']

  args.outputs.labels << [
    640,                   # X
    400,                   # Y
    "Metal Warrior Search for Valhalla",         # TEXT
    40,                     # SIZE_ENUM
    1,                     # ALIGNMENT_ENUM
    255,                     # RED
    0,                     # GREEN
    0,                     # BLUE
    255,                   # ALPHA
    "fonts/GrimoireOfDeath-2O2jX.ttf"   # FONT
  ]

  args.outputs.labels << [
    640,                   # X
    200,                   # Y
    "Press SPACE to start",         # TEXT
    20,                     # SIZE_ENUM
    1,                     # ALIGNMENT_ENUM
    255,                     # RED
    0,                     # GREEN
    0,                     # BLUE
    255,                   # ALPHA
    "fonts/GrimoireOfDeath-2O2jX.ttf"   # FONT
  ]
end

 # display valhalla, automatic walk the champ into the hall.
 def winner_ending args
  if @game_ending_timer > 48
    args.outputs.sprites << [0, 0, 1280, 720, 'sprites/background/Walhalla_(1896)_by_Max_Brückner.jpg']

  else
    args.outputs.sprites << [0, 0, 1280, 720, 'sprites/background/Walhall_by_Emil_Doepler.jpg']
    player.x = 700
    player.y = 200
    player.w = 280
    player.h = 240

  end

  # Enlarge her
  if @game_ending_timer==60
    player.x = 1150
    player.flip_horizontally = true
    @game_ending_timer -= 1

  else

    if @game_ending_timer > 55

      # Move the player towards the hall
      player.x -= 2

    elsif @game_ending_timer > 49

      # Shrink her as she gets close
      player.y += 1
      player.x -= 1

      if player.w > 70 and player.y > 200
        player.w -= 0.5
        player.h -= 0.5
      end

    elsif @game_ending_timer > 48
      player.y += 1

    else


    end

    @game_ending_timer -= 1 if (args.state.tick_count % 60) == 0
  end
end
