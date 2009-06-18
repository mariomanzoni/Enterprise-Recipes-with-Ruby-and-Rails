#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

describe "A model" do
  fixtures :things
  it "should tell you its required fields" do
    Thing.new.should have(1).error_on(:name)
  end
  
  it "should tell you how many records it has" do
    Thing.should have(:no).records
    Thing.create(:name => "THE THING")
    Thing.should have(1).record
  end
end
