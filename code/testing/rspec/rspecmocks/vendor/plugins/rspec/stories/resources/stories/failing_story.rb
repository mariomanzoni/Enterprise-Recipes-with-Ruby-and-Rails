#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
$:.push File.join(File.dirname(__FILE__), *%w[.. .. .. lib])

require 'spec/story'

Story "Failing story",
%(As an RSpec user
  I want a failing test
  So that I can observe the output) do

  Scenario "Failing scenario" do
    Then "true should be false" do
      true.should == false
    end
  end
end
