def tick args
  initialize_game args

  args.outputs.labels << {
    x:                       640,
    y:                       500,
    text:                    "dragonruby",
    size_enum:               2,
    alignment_enum:          1,
    r:                       155,
    g:                       50,
    b:                       50,
    a:                       255,
    font:                    "fibberish.ttf"





  #args.outputs.labels  << [640, 500, 'Metal Warrior', 25, 1]
  #args.outputs.labels  << [640, 460, 'Go to docs/docs.html and read it!', 5, 1]
  #args.outputs.labels  << [640, 420, 'Join the Discord! http://discord.dragonruby.org', 5, 1]
  background args
  move args

  #if args.state.x <= 1000
  #  args.state.x += 5
  #else
  #  args.state.x = 576
  #end =end
  end

  def background args
    args.outputs.solids << [0, 0, 1280, 720, 0, 0, 255, 100]
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

    args.outputs.sprites << [args.state.x, args.state.y, 224 * 2.5, 32 * 2.5, 'wolf.png']

  end

  def initialize_game args
  args.state.x ||= 576
  args.state.y ||= 65
  args.state.screenWidth ||= 1280
  end
