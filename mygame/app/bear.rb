class Bear < Creature

    def initialize(args)
        super
        @x = 100
        @y = 50
        @health = 40
        @damage = 20
        @speed = 3
        @move = true
        @count = 3
        @hold_for = 10
        @width = 76
        @creature_hash = {
            x: @x,
            y: @y,
            w: 76 * 3.5,
            h: 64 * 3.5,
            path: 'sprites/bear/black_bear_2.png',
            source_x: 76,
            source_y: 0,
            source_w: @width,
            source_h: 64,
            flip_horizontally: false,
          } 
    end
end