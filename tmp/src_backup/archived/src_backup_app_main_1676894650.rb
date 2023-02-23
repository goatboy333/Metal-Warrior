def tick args
  # STEP 1: Define when you want the animation to start.
  # The animation in this case will start in 3 seconds
  start_animation_on_tick = 180

  # STEP 2: Get the frame_index given the start tick.
  sprite_index = 
    start_animation_on_tick.frame_index count: 10,    # how many sprites?
                                        hold_for: 4,  # how long to hold each sprite?
                                        repeat: true  # should it repeat?

  # STEP 3: frame_index will return nil if the frame hasn't arrived yet
  #         default it to the first tile if that's the case
  sprite_index ||= 0  
  
  # use the sprite_index to determine the source rectangle/x offset and render
  # that specific 16x16 area
  args.outputs.sprites << {
    x: 10,
    y: 10,
    w: 60
    h: 32
    path:  "sprites/wolf.png",
    source_x: 16 * sprite_index,
    source_y: 0,
    source_w: 16,
    source_h: 16
  }
end
