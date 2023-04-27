class Bear < Creature

    def initialize(args)
        super
        @health = 40
        @damage = 20
        @speed = 3
        @move = true
        @count = 3
        @hold_for = 10
        @creature_hash = {
            x: 100,
            y: 50,
            w: 76 * 3.5,
            h: 64 * 3.5,
            path: 'sprites/bear/black_bear_2.png',
            source_x: 76,
            source_y: 0,
            source_w: 76,
            source_h: 64,
            flip_horizontally: false,
          } 
    end
end