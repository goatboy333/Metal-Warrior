require 'app/debug.rb'
require 'app/backgrounds.rb'
require 'app/creature.rb'


def tick(args)
  initialize_game args
  debug args
  background args
  middleground(args)
  foreground args
  #musicBackground args
  move args
  check_spacebar_spear(args)
  weapon_spear(args)
  #weapon_spear(args)

  enemies_move args

  args.gtk.hide_cursor

  args.state.fireballs ||= []
  if args.inputs.keyboard.key_down.z
    args.state.fireballs << [args.state.player.x,args.state.player.y,"fireball"]
  end
  args.state.fireballs.each do |fireball|
    args.outputs.labels << fireball
  end
end

def musicBackground args
  args.outputs.sounds << 'sounds/forest.ogg'

end

def move_right(args)
  if args.state.player.x >= (args.grid.w - 300) and args.state.groundStartPosX > -1310
    args.state.backgroundX -= 1
    args.state.groundStartPosX -= 5
  elsif args.state.player.x < (args.grid.w - 300)
    args.state.player.x += args.state.player.speed
    args.state.player.direction = -1
  end
end

def move_left(args)
  if args.state.player.x <= 100 and args.state.groundStartPosX < 0
    args.state.backgroundX += 1
    args.state.groundStartPosX += 5
  elsif args.state.player.x > 100
    args.state.player.x -= args.state.player.speed
    args.state.player.direction = 1
  end
end

def move(args)
  start_animation_on_tick = 0

  hash_sprites = {
    x: args.state.player.x,
    y: args.state.player.y,
    w: 100 * 2.5,
    h: 74 * 2.5,
    path: 'sprites/villager/Run/villager_run.png',
    source_x: 100,
    source_y: 0,
    source_w: 100,
    source_h: 74,
    flip_horizontally: args.state.player.direction > 0,
  }

  move = true

  if args.inputs.right
    move_right(args)
  elsif args.inputs.left
    move_left(args)
  else
    move = false
  end

  if args.inputs.up and args.state.player.y == args.state.player.base
    args.state.player.jump = true
  end

  if args.state.player.y > args.state.player.base and args.state.player.jump == false
    args.state.player.y -= args.state.player.speed

  elsif args.state.player.y > 250
    args.state.player.jump = false

  elsif args.state.player.jump
    hash_sprites[:path] = 'sprites/villager/Jump/villager_jump.png'
    args.state.player.y += args.state.player.speed
  end

  if move
    sprite_index = start_animation_on_tick.frame_index count: 6, 	# how many
      hold_for: 5,  # how long
      repeat: true  # should it repeat?
  else
    sprite_index = start_animation_on_tick.frame_index count: 5, 	# how many
      hold_for: 10,  # how long
      repeat: true  # should it repeat?
  end

  hash_sprites[:source_x] = 100 * sprite_index if move

  args.outputs.sprites << hash_sprites
end

def enemies_move(args)

  if args.tick_count % 160 == 0
    args.state.enemies_count += 1
    puts args.state.enemies_count

    args.state.enemies << {x: 1200, y: 50, direction: 1} unless args.state.enemies_count > 2
  end

  start_animation_on_tick = 0

  args.state.enemies.each do |enemy|
    hash_sprites = {
      x: enemy[:x],
      y: enemy[:y],
      w: 50 * 3.5,
      h: 32 * 3.5,
      path: 'sprites/enemies/wolf.png',
      source_x: 60,
      source_y: 0,
      source_w: 50,
      source_h: 32,
      flip_horizontally: enemy[:direction] > 0,
    }

    if enemy[:x] < args.state.player.x + 140 and enemy[:x] > args.state.player.x - 120

    elsif enemy[:x] > args.state.player.x + 100
      enemy[:x] -= 1
      enemy[:direction] = 1

    elsif enemy[:x] < args.state.screenWidth
      enemy[:x] += 1
      enemy[:direction] = -1
    else

    end

    sprite_index = start_animation_on_tick.frame_index count: 4, 	# how many
      hold_for: 5,  # how long
      repeat: true  # should it repeat?

    hash_sprites[:source_x] = 60 * sprite_index

    args.outputs.sprites << hash_sprites
  end
end

def check_spacebar_spear(args)
  if args.inputs.keyboard.control
    args.state.spear.active = true
    args.state.spear.y = args.state.player.y + 55
    args.state.spear.direction = args.state.player.direction 
    if args.state.player.direction > 0
      args.state.spear.x = args.state.player.x + 80
  
    elsif args.state.player.direction < 0
      args.state.spear.x = args.state.player.x - 10
  
    end
  end
end

def weapon_spear(args)
  

  spear_sprite = {
    x: args.state.spear.x, # = args.state.player.x+ 80,
    y: args.state.spear.y, # = args.state.player.y + 55,
    w: 100 * 1.5,
    h: 27,
    path: 'sprites/weapons/spear.png',
   
    flip_horizontally: args.state.player.direction > 0,
  }

  if args.state.spear.active
    args.state.spear.x -= 10 * args.state.spear.direction
    
  end

  args.outputs.sprites << spear_sprite

end

def initialize_game(args)
  args.state.player.x ||= 250
  args.state.player.y ||= 50
  args.state.player.jump ||= false
  args.state.player.base ||= 50
  args.state.player.speed = 10
  args.state.player.direction ||= -1
  args.state.enemies ||= [{x: 1200, y: 50, direction: 1}]
  args.state.spear.x  ||= args.state.player.x
  args.state.spear.y ||= args.state.player.y
  args.state.spear.active ||= false
  args.state.spear.direction ||= -1
  args.state.screenWidth ||= 1280
  args.state.trigger_sample ||= 0
  args.state.backgroundX ||= -10
  args.state.backgroundY ||= 0
  args.state.groundX ||= 0
  args.state.groundStartPosX ||= 0
end
