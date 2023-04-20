class Player < Creature

  attr_reader :flipped, :x

    def initialize(args) 
        super
        @x = args.state.player.x
        @y = args.state.player.y
        @count = 6
        @width = 100
        @move = false
        @hero = true
        @heroflipped = @flipped

        @creature_hash = {
            x: @x,
            y: @y,
            w: 100 * 2.5,
            h: 74 * 2.5,
            path: 'sprites/villager/Run/villager_run.png',
            source_x: 100,
            source_y: 0,
            source_w: 100,
            source_h: 74,
            flip_horizontally: @flipped,
        }
    end



  def check_keyboard(args)
    
    checkRight(args)
    checkLeft(args)
    checkControl(args)
  end

  def checkRight(args)
    if args.inputs.right
      #move_right(args)
      @creature_hash[:x] += 5
      args.state.player.x =  @creature_hash[:x]
      @creature_hash[:flip_horizontally] = false
      @move = true
    end  
  end

  def checkLeft(args)  
    if args.inputs.left
      #move_left(args)
    @creature_hash[:x] -= 5
    args.state.player.x =  @creature_hash[:x]
    @creature_hash[:flip_horizontally] = true  
    @move = true
    end
  end
  
  def checkControl(args)
    if args.inputs.keyboard.control
      create_spear_attack(args)
    end
  end

  def create_spear_attack(args)
    args.state.current_time = args.tick_count
    
    if args.state.current_time - args.state.previous_time > 3
      args.state.number_of_spears += 1
      #playerDirection = @creature_hash[:flip_horizontally] #(@creature_hash[:x]
      WeaponSpears[args.state.number_of_spears] = Spear.new(args)
      args.state.previous_time = args.state.current_time
    end
    
    args.state.previous_time = args.state.current_time
  
  end

  def return_x(args)
    return @creature_hash[:x]
  end

end

def return_hero_direction(args)
  return @creature_hash[:flip_horizontally]
end

