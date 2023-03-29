
def background(args)
    # checks boundaries and render background 
    background_paste ||= 0
  
    args.outputs.background_color = [50, 0, 255]
    
    4.times do
    args.outputs.sprites << [background_paste, 0, 320, 720, 'sprites/background/back.png']   
    background_paste += 320
    end
  end 
  
  def middleground(args)
    # checks boundaries and render mid background
    args.outputs.background_color = [50, 0, 255]
    args.outputs.sprites << [args.state.backgroundX, 0, 2560, 720, 'sprites/middleground/middle768272.png']
  end
  
  def foreground args
    # check boundaries and renders ground
    args.state.groundX =  args.state.groundStartPosX
  
    (args.state.screenWidth * 2 / 69).times do
      args.outputs.sprites << [args.state.groundX, 0, 69, 64, 'sprites/foreground/tile1.png']
      args.state.groundX += 69
    end
  end