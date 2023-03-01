def tick (args)
  initialize_game args

  args.outputs.labels << {
    x:                       640,
    y:                       500,
    text:                    "Metal Warrior",
    size_enum:               33,
    alignment_enum:          1,
    r:                       0,
    g:                       0,
    b:                       50,
    a:                       255,
    font:                    "fibberish.ttf"

  }

  args.outputs.labels << {
    x:                       640,
    y:                       500,
    text:                    "Metal Warrior",
    size_enum:               30,
    alignment_enum:          1,
    r:                       255,
    g:                       0,
    b:                       50,
    a:                       255,
    font:                    "fibberish.ttf"

  }

  background args
  move args

  end

  def background (args)
    args.outputs.solids << [0, 0, 1280, 720, 0, 0, 255, 180]
    x = 0
    (args.state.screenWidth / 69).times do
    
      args.outputs.sprites << [x, 0, 69, 64, 'tile1.png']
      x += 69
    end
    
  end

  def move(args)

    start_animation_on_tick = 0


    sprite_index = start_animation_on_tick.frame_index count: 4, 	# how many
                                                       hold_for: 5,  # how long
                                                       repeat: true  # should it repeat?

    hash_sprites = {
      x: args.state.x, 
      y: args.state.y, 
      w: 50 * 2.5, 
      h: 32 * 2.5, 
      path: 'wolf.png',
      source_x: 60,
      source_y: 0,
      source_w: 50,
      source_h: 32,
      flip_horizontally: args.state.player.direction > 0,
    }

    if args.inputs.right
      args.state.x += 5
      args.state.player.direction = -1
      hash_sprites[:source_x] = 60 * sprite_index 
    elsif args.inputs.left
      args.state.x -= 5
      args.state.player.direction = 1
      hash_sprites[:source_x] = 60 * sprite_index
      args.state.trigger_sample = 1 
    #elsif args.inputs.keyboard.space
    #  args.outputs.sounds << 'sounds/gun.wav'

    end
    
    args.outputs.sprites << hash_sprites
    if args.state.trigger_sample == 1
      args.outputs.sounds << 'sounds/gun.wav'
      args.state.trigger_sample = 0
    end

  end

  def initialize_game (args)
  args.state.x ||= 576
  args.state.y ||= 50
  args.state.screenWidth ||= 1280
  args.state.player.direction ||= 1
  args.state.trigger_sample ||= 0
  end
