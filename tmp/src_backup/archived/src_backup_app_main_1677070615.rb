def tick args
  initialize_game args

  args.outputs.labels  << [640, 500, 'Hello World!', 5, 1]
  args.outputs.labels  << [640, 460, 'Go to docs/docs.html and read it!', 5, 1]
  args.outputs.labels  << [640, 420, 'Join the Discord! http://discord.dragonruby.org', 5, 1]
  background args
  move args

  #if args.state.x <= 1000
  #  args.state.x += 5
  #else
  #  args.state.x = 576
  #end =end
  end

  def background args
    args.outputs.solids << (0, 0, 1280, 720, 0, 0, 255, 255)
    x = 0
    for loop in 0..(args.state.screenWidth / 69)
    
      args.outputs.sprites << [x, 0, 69, 64, 'tile1.png']
      x += 69
    end
    
  end

  def move args
    if args.inputs.right
      args.state.x += 5
    end
  
    if args.inputs.left
      args.state.x -= 5
    end

    args.outputs.sprites << [args.state.x, args.state.y, 524, 72, 'wolf.png']

  end

  def initialize_game args
  args.state.x ||= 576
  args.state.y ||= 65
  args.state.screenWidth ||= 1280
  end
