#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class WbmpImage
  attr_reader :width, :height, :image_data
  
  def initialize(width, height, image_data)
    @width, @height, @image_data = width, height, image_data
  end
end



class WbmpImage
  def self.from_raw_data(raw_data)
    type, header = raw_data.slice!(0, 2) 
    unless type == 0 && header == 0
      raise 'Unsupported image type!'
    end
    width = get_multibyte_integer(raw_data)
    height = get_multibyte_integer(raw_data)
    image_data = get_image_data(width, height, raw_data)
    WbmpImage.new(width, height, image_data)
  end
  
  def self.get_multibyte_integer(raw_data)
    multi_int = 0
    while raw_data[0][7] == 1 
      multi_int = (multi_int << 7) | (raw_data.shift & 0x7f) 
    end
    (multi_int << 7) | raw_data.shift
  end
  
  def self.get_image_data(width, height, raw_data)
    bytes_per_row = width / 8
    bytes_per_row += 1 if (width % 8) != 0
    image_data = []
    height.times { image_data << raw_data.slice!(0, bytes_per_row) }
    image_data
  end
end



class WbmpImage
  def to_ascii_art
    ascii_art = ''
    @image_data.each do |line|
      line.each do |byte|
        7.downto(0) { |i| ascii_art << (byte[i] == 1 ? '*' : '.') }
      end
      ascii_art << "\n"
    end
    ascii_art
  end
end


class WbmpImage
  def self.load(filename)
    from_raw_data(IO::read(filename).unpack('C*'))
  end
end
  
if __FILE__ == $0
  image = WbmpImage.load(ARGV[0])
  puts image.to_ascii_art
end
