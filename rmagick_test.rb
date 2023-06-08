require 'rmagick'

image = Magick::Image.read('test.png').first
width = image.columns
height = image.rows

puts "Original: #{width} x #{height}"

# Trim the image
image.trim!

# # Reset the page to remove any virtual canvas
# image.page = Magick::Rectangle.new(0, 0, 0, 0)

# Save the modified image
image.write('output.png')
width = image.columns
height = image.rows

puts "New: #{width} x #{height}"
