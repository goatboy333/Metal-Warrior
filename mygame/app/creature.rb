class Creature

    attr_accessor :health

    def initialize(args)
        @x = 0
        @y = 0
        @health = 100
        @damage = 4
        @speed = 5
        @flipped = false
        @count = 4
        @hold_for = 5
        @width = 71
    end

    def creature_hash

    end

    def take_damage(value)
        @health -= value
        if @health < 0
            puts "DEAD"
        end
    end

    def move()

    end


    def animate(args)
        start_animation_on_tick = 0

        sprite_index = start_animation_on_tick.frame_index @count, 	# how many
            @hold_for,  # how long
            repeat: true  # should it repeat?
        
        @creature_hash[:source_x] = @width * sprite_index #if @move

        args.outputs.sprites << @creature_hash
    end

    def stats(args)
        puts self.class
        puts @damage
        puts @speed
        puts @health
    end
end