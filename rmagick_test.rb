require 'rmagick'

sheet = Magick::Image.read("sheet.png").first
width = sheet.columns
height = sheet.rows

puts "Original: #{width} x #{height}"

index = 10

y = 11

sheet.crop!(288 * index, 128 * (15-y), 288, 128)

sheet.trim!

# sheet.write("sheet_output.png")
width = sheet.columns
height = sheet.rows

puts "New: #{width} x #{height}"

exit

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
