class Player < Creature

    def initialize(args) 
        super
        @x = args.state.player.x
        @y = args.state.player.y
        @count = 6
        @width = 100
        @move = false

        @creature_hash = {
            x: @x,
            y: @y,
            w: 100 * 2.5,
            h: 74 * 2.5,
            path: 'sprites/villager/Run/villager_run.png',
            source_x: 100,
            source_y: 0,
            source_w: 100,
            source_h: 74,
            flip_horizontally: @flipped,
        }
    end
end


def check_keyboard(args)
  move = true

  if args.inputs.right
    move_right(args)
  elsif args.inputs.left
    move_left(args)
  else
    move = false
  end
end