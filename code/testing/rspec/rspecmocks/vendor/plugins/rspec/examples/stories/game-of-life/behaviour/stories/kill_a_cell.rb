#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.join(File.dirname(__FILE__), *%w[helper])

Story 'I can kill a cell',
  %(As a game producer
  I want to kill a cell
  So that when I make a mistake I don't have to start again), :steps_for => :life do
  
  Scenario "bang, you're dead" do
    
    Given 'a game that looks like', %(
      XX.
      .X.
      ..X
    ) do |dots|
      @game = Game.from_string dots
    end
    When 'I destroy the cell at', 0, 1 do |row,col|
      @game.destroy_at(row,col)
    end
    Then 'the grid should look like', %(
      X..
      .X.
      ..X
    )
  end
end
