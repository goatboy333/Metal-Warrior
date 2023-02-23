def tick args
  args.state.x ||= 576
  args.state.y ||= 280

  args.outputs.labels  << [640, 500, 'Hello World!', 5, 1]
  args.outputs.labels  << [640, 460, 'Go to docs/docs.html and read it!', 5, 1]
  args.outputs.labels  << [640, 420, 'Join the Discord! http://discord.dragonruby.org', 5, 1]
  args.outputs.sprites << [300, 300, 32, 32, '/layers/tiles.png']
  move args

  #if args.state.x <= 1000
  #  args.state.x += 5
  #else
  #  args.state.x = 576
  #end =end
  end

  def move args
    if args.inputs.right
      args.state.x += 5
    end
  
    if args.inputs.left
      args.state.x -= 5
    end
    if args.inputs.up 
      args.state.y += 5
    end
  
    if args.inputs.down
      args.state.y -= 5
    end

    args.outputs.sprites << [args.state.x, args.state.y, 224, 32, 'wolf.png']

  end
