#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class Grid
  
  attr_accessor :contents
  
  def initialize(rows, cols)
    @contents = []
    rows.times do @contents << [0] * cols end
  end
  
  def rows
    @contents.size
  end
  
  def columns
    @contents[0].size
  end
  
  def ==(other)
    self.contents == other.contents
  end
  
  def create_at(row,col)
    @contents[row][col] = 1
  end
  
  def destroy_at(row,col)
    @contents[row][col] = 0
  end
  
  def self.from_string(str)
    row_strings = str.split(' ')
    grid = new(row_strings.size, row_strings[0].size)
    
    row_strings.each_with_index do |row, row_index|
      row_chars = row.split(//)
      row_chars.each_with_index do |col_char, col_index|
        grid.create_at(row_index, col_index) if col_char == 'X'
      end
    end
    return grid
  end
  
end
