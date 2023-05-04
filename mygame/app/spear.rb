class Spear
  
    def initialize(player_x, player_y, flipped)
        @player_x = player_x 
        @player_y = player_y + 65
        @direction = flipped
        @hash_spear = {
            speed: 10,
            x: @player_x,
            y: @player_y,
            w: 100 * 1.5,
            h: 27,
            path: 'sprites/weapons/spear.png',
            flip_horizontally: @direction
        }
    end

    def display(args)
        args.outputs.sprites << @hash_spear  
    end

    def move(args)
        if @direction
            @hash_spear[:x] -= @hash_spear[:speed]
        else
            @hash_spear[:x] += @hash_spear[:speed]
        end
    end
    
    def hit(args)
        args.state.enemies.reject do |enemy|
            #spear_rect = [@hash_spear.x,@hash_spear.y,@hash_spear.w,@hash_spear.h]
            #GTK::Geometry.intersect_rect? spear_rect, enemy_rect
            true
        end
    end
end

