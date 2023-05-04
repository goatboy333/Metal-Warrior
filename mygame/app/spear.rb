class Spear

    def initialize(player_x, player_y, flipped)
        SPEED = 10
        @player_x = player_x 
        @player_y = player_y + 65
        @direction = flipped
        @hash_spear = {
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
            @hash_spear[:x] -= SPEED
        else
            @hash_spear[:x] += SPEED
        end
    end
    
    def hit(enemies)
        enemies.each do |enemy|
            
            #puts "HIT #{enemy}"
        end
    end
end

