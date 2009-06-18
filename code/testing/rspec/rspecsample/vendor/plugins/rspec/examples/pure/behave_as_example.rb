#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

def behave_as_electric_musician
  respond_to(:read_notes, :turn_down_amp)
end

def behave_as_musician
  respond_to(:read_notes)
end

module BehaveAsExample
  
  class BluesGuitarist
    def read_notes; end
    def turn_down_amp; end
  end
  
  class RockGuitarist
    def read_notes; end
    def turn_down_amp; end
  end
  
  class ClassicGuitarist
    def read_notes; end
  end
  
  describe BluesGuitarist do
    it "should behave as guitarist" do
      BluesGuitarist.new.should behave_as_electric_musician
    end
  end

  describe RockGuitarist do
    it "should behave as guitarist" do
      RockGuitarist.new.should behave_as_electric_musician
    end
  end

  describe ClassicGuitarist do
    it "should not behave as guitarist" do
      ClassicGuitarist.new.should behave_as_musician
    end
  end
  
end
