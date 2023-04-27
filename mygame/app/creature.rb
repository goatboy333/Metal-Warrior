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
        @hero = false
        @move = true

        @create_hash = {}
    end

    def take_damage(value)
        @health -= value
        if @health < 0
            puts "DEAD"
        end
    end

    def follow_the_player(args)
        if @creature_hash[:x] < args.state.player.x + 140 and @creature_hash[:x] > args.state.player.x - 120

        elsif @creature_hash[:x] > args.state.player.x + @speed #was @speed00 which i assume was a typo?
            @creature_hash[:x] -= @speed
            @creature_hash[:flip_horizontally] = false

        elsif @creature_hash[:x] < args.state.screenWidth
            @creature_hash[:x] += @speed
            @creature_hash[:flip_horizontally] = true
        end
    end

    def animate(args)
        start_animation_on_tick = 0

        sprite_index = start_animation_on_tick.frame_index @count, 	# how many
            @hold_for,  # how long
            repeat: true  # should it repeat?
        
        if !@hero
            follow_the_player(args)
        end

        @creature_hash[:source_x] = @creature_hash[:source_w] * sprite_index if @move
 
        args.outputs.sprites << @creature_hash

        if @hero
            @move = false
        end
    end

    def stats(args)
        puts self.class
        puts @damage
        puts @speed
        puts @health
    end
end