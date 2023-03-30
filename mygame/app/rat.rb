class Rat < Creature
 
    def initialize(args)
        super
        @damage = 1
        @speed = 4
        @health = 5
        @x =100
        
        @count = 4
        @hold_for = 5
        @width = 71

        @creature_hash= {
            x: @x,
            y: 0,
            w: 70 * 2,
            h: 58 * 2,
            path: 'sprites/rat/rat-charset.png',
            source_x: 0,
            source_y: 100,
            source_w: 71,
            source_h: 58,
            flip_horizontally: @flipped > 0,
          } 
          
          args.outputs.sprites << @creature_hash
    end
end