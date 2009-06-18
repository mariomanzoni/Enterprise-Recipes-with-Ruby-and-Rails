#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

describe "error_on" do
  it "should provide a message including the name of what the error is on" do
    have(1).error_on(:whatever).description.should == "should have 1 error on :whatever"
  end
end

describe "errors_on" do
  it "should provide a message including the name of what the error is on" do
    have(2).errors_on(:whatever).description.should == "should have 2 errors on :whatever"
  end
end
