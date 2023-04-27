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

    def weaponDisplay(args)
        args.outputs.sprites << @hash_spear  
    end

    def moveSpear(args)
        @hash_spear[:x] += SPEED
    end
    
=begin
    def display_spear(args)
        
        if args.state.number_of_spears > 0
            if @direction
                @hash_spear[:flip_horizontally] = Player1.return_hero_direction(args)
                @hash_spear[:x] = Player1.return_x(args)
                args.outputs.sprites << @hash_spear
            elsif !@direction
                @hash_spear[:flip_horizontally] = Player1.return_hero_direction(args)
                @hash_spear[:x] = Player1.return_x(args) # make sure the fireball start at the front of character when flipped 
                args.outputs.sprites << @hash_spear
            end
        end
    end
=end
end

# -------------------------------------------
def playerDirectionForSpear(args)
    @hash_spear[:flip_horizontally] = return_hero_direction(args)
end

def display_spear(args)
    if args.state.number_of_spears > 0
        i = 1
        args.state.number_of_spears.times {
        args.state.weapon_spears[i].weaponDisplay(args)
        args.state.weapon_spears[i].moveSpear(args)
        i += 1
        }
    end
end