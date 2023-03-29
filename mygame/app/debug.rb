def debug args
    args.outputs.labels << {
      x:                       640,
      y:                       300,
      text:                    args.state.player.x,
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