class Player < Creature

    def initialize(args) 
        super
        @x = args.state.player.x
        @y = args.state.player.y
        @move = false
        @speed = 5
    end

    def player_hash(args)

        hash_sprites = {
            x: @x,
            y: @y,
            w: 100 * 2.5,
            h: 74 * 2.5,
            path: 'sprites/villager/Run/villager_run.png',
            source_x: 100,
            source_y: 0,
            source_w: 100,
            source_h: 74,
            flip_horizontally: args.state.player.direction > 0,
        }

    end
    return hash_sprites
end

    def animate_player(args)
        start_animation_on_tick = 0

        if move
            sprite_index = start_animation_on_tick.frame_index count: 6, 	# how many
                hold_for: 5,  # how long
                repeat: true  # should it repeat?
        else
            sprite_index = start_animation_on_tick.frame_index count: 5, 	# how many
                hold_for: 10,  # how long
                repeat: true  # should it repeat?
        end
    
    hash_sprites[:source_x] = 100 * sprite_index if move
    args.outputs.sprites << hash_sprites
    end

def move_right(args)
    if @x >= (args.grid.w - 300) and args.state.groundStartPosX > -1310
      args.state.backgroundX -= 1
      args.state.groundStartPosX -= 5
    elsif @x < (args.grid.w - 300)
      @x += args.state.player.speed
      args.state.player.direction = -1
    end
  end
  
  def move_left(args)
    if @x <= 100 and args.state.groundStartPosX < 0
      args.state.backgroundX += 1
      args.state.groundStartPosX += 5
    elsif @x > 100
      @x -= args.state.player.speed
      args.state.player.direction = 1
    end
  end

def check_keyboard(args)
  move = true

  if args.inputs.right
    move_right(args)
  elsif args.inputs.left
    move_left(args)
  else
    move = false
  end
end