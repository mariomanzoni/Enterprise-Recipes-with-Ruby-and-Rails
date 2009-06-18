#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class Game
  attr_accessor :grid
  def initialize(rows,cols)
    @grid = Grid.new(rows, cols)
  end
  
  def create_at(row,col)
    @grid.create_at(row,col)
  end
  
  def destroy_at(row,col)
    @grid.destroy_at(row, col)
  end
  
  def self.from_string(dots)
    grid = Grid.from_string(dots)
    game = new(grid.rows, grid.columns)
    game.instance_eval do
      @grid = grid
    end
    return game
  end
end
