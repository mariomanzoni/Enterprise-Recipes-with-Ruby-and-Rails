#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'life'

describe Game do
  it 'should have a grid' do
    # given
    game = Game.new(5, 5)
    
    # then
    game.grid.should be_kind_of(Grid)
  end
  
  it 'should create a cell' do
    # given
    game = Game.new(2, 2)
    expected_grid = Grid.from_string( 'X. ..' )
    
    # when
    game.create_at(0, 0)
    
    # then
    game.grid.should == expected_grid
  end
  
  it 'should destroy a cell' do
    # given
    game = Game.new(2,2)
    game.grid = Grid.from_string('X. ..')
    
    # when
    game.destroy_at(0,0)
    
    # then
    game.grid.should == Grid.from_string('.. ..')
  end
end
