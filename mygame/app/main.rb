require 'app/debug.rb'
require 'app/backgrounds.rb'
require 'app/creature.rb'
require 'app/rat.rb'
require 'app/eagle.rb'
require 'app/bear.rb'
require 'app/wolf.rb'
require 'app/player.rb'
require 'app/spear.rb'


def tick(args)
  initialize_game args
  #music_background args
  background args
  middleground(args)
  foreground args

  @player.animate(args)
  @rat.animate(args)
  @wolf.animate(args)  #why are these instance variables?
  @bear.animate(args)
  @eagle.animate(args)
  @player.check_keyboard(args)
  display_spear(args)
end

def initialize_game(args)
  args.gtk.hide_cursor
  args.state.player.x ||= 250
  args.state.player.y ||= 50
  args.state.player.jump ||= false
  args.state.player.base ||= 50
  args.state.player.speed = 10
  args.state.player.direction ||= -1
  args.state.enemies ||= [{x: 1200, y: 50, direction: 1}]
  args.state.spear.active ||= false
  args.state.spear.direction ||= -1
  args.state.screenWidth ||= 1280
  args.state.trigger_sample ||= 0
  args.state.backgroundX ||= -10
  args.state.backgroundY ||= 0
  args.state.groundX ||= 0
  args.state.groundStartPosX ||= 0
  
  @player ||= Player.new(args)
  @rat ||= Rat.new(args)
  @eagle ||= Eagle.new(args)
  @bear ||= Bear.new(args)
  @wolf ||= Wolf.new(args)

  [@rat,@eagle,@bear,@wolf].each do |enemy|
    args.state.enemies << enemy
  end

  args.state.weapon_spears ||= []  # array to record the spear instanciations

  args.state.current_time ||= 0 # Record current time
  args.state.previous_time ||= 0 # record the time at the end of a function to compare to current time
end

def display_spear(args)


  args.state.weapon_spears.each do |spear| 
    spear.hit(args)
    spear.display(args)
    spear.move(args)
  end
end

def music_background args
  args.outputs.sounds << 'sounds/forest.ogg'
end