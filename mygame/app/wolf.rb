class Wolf < Creature

    def initialize(args)
        super
        @health = 20
        @damage = 10
        @speed = 8
        @move = true
        @count = 4
        @hold_for = 5
        @creature_hash = {
            x: 70,
            y: 50,
            w: 50 * 3.5,
            h: 32 * 3.5,
            path: 'sprites/enemies/wolf.png',
            source_x: 56,
            source_y: 0,
            source_w: 56,
            source_h: 32,
            flip_horizontally: false,
          } 
    end
end