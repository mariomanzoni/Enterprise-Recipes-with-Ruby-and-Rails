#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "The anything() mock argument constraint matcher" do
  specify { anything.should == Object.new }
  specify { anything.should == Class }
  specify { anything.should == 1 }
  specify { anything.should == "a string" }
  specify { anything.should == :a_symbol }
end

describe "The boolean() mock argument constraint matcher" do
  specify { boolean.should == true }
  specify { boolean.should == false }
  specify { boolean.should_not == Object.new }
  specify { boolean.should_not == Class }
  specify { boolean.should_not == 1 }
  specify { boolean.should_not == "a string" }
  specify { boolean.should_not == :a_symbol }
end

describe "The an_instance_of() mock argument constraint matcher" do
  # NOTE - this is implemented as a predicate_matcher - see example_group_methods.rb
  specify { an_instance_of(String).should == "string"  }
end
