def tick args
  args.state.x ||= 576
  args.state.y ||= 280

  args.outputs.labels  << [640, 500, 'Hello World!', 5, 1]
  args.outputs.labels  << [640, 460, 'Go to docs/docs.html and read it!', 5, 1]
  args.outputs.labels  << [640, 420, 'Join the Discord! http://discord.dragonruby.org', 5, 1]
  args.outputs.sprites << [arg.state.x, arg.state.y, 224, 32, 'wolf.png'] 
  arg.state.x += 1
end
