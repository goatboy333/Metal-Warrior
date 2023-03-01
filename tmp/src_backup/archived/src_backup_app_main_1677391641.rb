def tick (args)
  require 'app/bird.rb'
  initialize_game args
  debug args
  background args
  musicBackground args
  move args


end

def musicBackground args
  args.outputs.sounds << 'sounds/forest.ogg'

end

def debug args

  args.outputs.labels << {
      x:                       640,
      y:                       300,
      text:                    args.state.x,
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
      text:                    args.state.groundX,
      size_enum:               30,
      alignment_enum:          1,
      r:                       255,
      g:                       0,
      b:                       50,
      a:                       255,
      font:                    "fibberish.ttf"
  
    }
  
 end

  def background (args)
    
    # args.outputs.solids << [0, 0, 1280, 720, 0, 0, 255, 180]

    # checks boundaries and render mid background 
    
    args.outputs.background_color = [50, 0, 255]
    
    
    if args.state.backgroundX >= -10 and args.state.x <=100
      args.state.backgroundX = -10
      args.outputs.sprites << [args.state.backgroundX, 0, 2560, 720, 'sprites/middle768272.png']
    elsif
      args.outputs.sprites << [args.state.backgroundX, 0, 2560, 720, 'sprites/middle768272.png']   
    end

    if args.state.backgroundX <= -271 and args.state.x <= 850
      args.state.backgroundX = -271
      args.outputs.sprites << [args.state.backgroundX, 0, 2560, 720, 'sprites/middle768272.png']
    elsif
      args.outputs.sprites << [args.state.backgroundX, 0, 2560, 720, 'sprites/middle768272.png']   
    end

    ####################
    # check boundaries and renders ground
    
    args.state.groundX =  args.state.groundStartPosX

    if args.state.groundStartPosX >= 0 and args.state.x <= 100
      
      args.state.groundX and args.state.groundStartPosX = 0
      
      (args.state.screenWidth * 2 / 69).times do
      args.outputs.sprites << [args.state.groundX, 0, 69, 64, 'tile1.png']
      args.state.groundX += 69
      end
    elsif
        (args.state.screenWidth * 2 / 69).times do    
        args.outputs.sprites << [args.state.groundX, 0, 69, 64, 'tile1.png']
        args.state.groundX += 69
      end
    end 

  

  args.state.groundX =  args.state.groundStartPosX

    if args.state.groundStartPosX <= -1310 and args.state.x <= 850
      
      args.state.groundX and args.state.groundStartPosX = -1310
      
      (args.state.screenWidth * 2 / 69).times do
      args.outputs.sprites << [args.state.groundX, 0, 69, 64, 'tile1.png']
      args.state.groundX += 69
      end
    elsif
        (args.state.screenWidth * 2 / 69).times do    
        args.outputs.sprites << [args.state.groundX, 0, 69, 64, 'tile1.png']
        args.state.groundX += 69
      end
    end 

    bird.displayRock

    #=begin
    #sprite_rock1 = [700 ,50, 146, 75, 'sprites/rocksingle.png']
    #args.outputs.sprites << sprite_rock1 # rock test
    #if args.state.hash_sprites? args.state.sprite_rock1
    #  sprite_rock1 = [700 ,200, 146, 75, 'sprites/rocksingle.png']
    #  args.outputs.sprites << sprite_rock1 
    #end
    

  end

  def move(args)

    start_animation_on_tick = 0


    sprite_index = start_animation_on_tick.frame_index count: 4, 	# how many
                                                       hold_for: 5,  # how long
                                                       repeat: true  # should it repeat?

    hash_sprites = {
      x: args.state.x, 
      y: args.state.y, 
      w: 50 * 3.5, 
      h: 32 * 3.5, 
      path: 'wolf.png',
      source_x: 60,
      source_y: 0,
      source_w: 50,
      source_h: 32,
      flip_horizontally: args.state.player.direction > 0,
    }

    if args.inputs.right and args.state.x >= 850
        args.state.x = 850
        args.state.player.direction = -1
        args.state.backgroundX -= 1
        args.state.groundStartPosX -= 5
        if args.state.groundStartPosX <= -1315
          args.state.groundStartPosX = -1310
        end
      hash_sprites[:source_x] = 60 * sprite_index
    elsif args.inputs.right and args.state.x < 850
      
      args.state.x += 10
      args.state.player.direction = -1
      hash_sprites[:source_x] = 60 * sprite_index
    end

    if args.inputs.left and args.state.x <= 100
      args.state.x = 100
      args.state.player.direction = 1
      args.state.backgroundX += 1
      args.state.groundStartPosX += 5
      if args.state.groundStartPosX >= 5
        args.state.groundStartPosX = 0
      end
      hash_sprites[:source_x] = 60 * sprite_index

    elsif args.inputs.left and args.state.x > 100
      args.state.x -= 10
      args.state.player.direction = 1
      hash_sprites[:source_x] = 60 * sprite_index
      args.state.trigger_sample = 1 
    #elsif args.inputs.keyboard.space
    #  args.outputs.sounds << 'sounds/gun.wav'

    end
    
    args.outputs.sprites << hash_sprites
    if args.state.trigger_sample == 1
      # args.outputs.sounds << 'sounds/gun.wav'
      args.state.trigger_sample = 0
    end

  end

  def initialize_game (args)
    args.state.x ||= 250
    args.state.y ||= 50
    args.state.screenWidth ||= 1280
    args.state.player.direction ||= -1
    args.state.trigger_sample ||= 0
    args.state.backgroundX ||= -10
    args.state.backgroundY ||= 0
    args.state.groundX ||= 0
    args.state.groundStartPosX ||= 0
    bird = Bird.new
  end
