class Eagle < Creature

    def initialize(args)
        super
        @x = 700
        @y = 300
        @health = 10
        @damage = 3
        @speed = 5
        @move = true
        @count = 3
        @hold_for = 10
        @width = 32
        @creature_hash = {
            x: @x,
            y: @y,
            w: 50 * 3.5,
            h: 32 * 3.5,
            path: 'sprites/eagle/bird_2_eagle.png',
            source_x: 32,
            source_y: 128,
            source_w: @width,
            source_h: 32,
            flip_horizontally: @flipped > 0,
          } 
    end
end