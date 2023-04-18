class Spear

    def initialize(args)
        @x = args.state.player.x #xPos
        @y = args.state.player.y + 65
        @direction = false
        @hash_spear = {
            x: @x,
            y: @y,
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
        @hash_spear[:x] += 10
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

def display_spear(args)
    if args.state.number_of_spears > 0
        i = 1
        args.state.number_of_spears.times {
        WeaponSpears[i].weaponDisplay(args)
        WeaponSpears[i].moveSpear(args)
        i += 1
        }
    end
end