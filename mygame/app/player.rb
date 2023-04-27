class Player < Creature

  attr_reader :flipped, :x

    def initialize(args) 
        super 
        @count = 6
        @move = false
        @hero = true
  
        @creature_hash = {
            x: args.state.player.x,
            y: args.state.player.y,
            w: 100 * 2.5,
            h: 74 * 2.5,
            path: 'sprites/villager/Run/villager_run.png',
            source_x: 100,
            source_y: 0,
            source_w: 100,
            source_h: 74,
            flip_horizontally: @flipped
        }
    end

  def check_keyboard(args)
    move_right(args)
    move_left(args)
    attack(args)
  end

  def move_right(args)
    if args.inputs.right
      @creature_hash[:x] += 5
      args.state.player.x =  @creature_hash[:x]
      @creature_hash[:flip_horizontally] = false
      @move = true
    end  
  end

  def move_left(args)  
    if args.inputs.left
      @creature_hash[:x] -= 5
      args.state.player.x =  @creature_hash[:x]
      @creature_hash[:flip_horizontally] = true  
      @move = true
    end
  end
  
  def attack(args)
    if args.inputs.keyboard.control
      throw_spear(args)
    end
  end

  def throw_spear(args)
    args.state.current_time = args.tick_count
    
    if args.state.current_time - args.state.previous_time > 3
      args.state.number_of_spears += 1
      args.state.weapon_spears[args.state.number_of_spears] = Spear.new(@creature_hash[:x],
        @creature_hash[:y],
        @creature_hash[:flip_horizontally])
      args.state.previous_time = args.state.current_time
    end
    
    args.state.previous_time = args.state.current_time
  
  end

  # -----------------------------------------
  def return_x(args)
    return @creature_hash[:x]
  end

end

def return_hero_direction(args)
  return @creature_hash[:flip_horizontally]
end

