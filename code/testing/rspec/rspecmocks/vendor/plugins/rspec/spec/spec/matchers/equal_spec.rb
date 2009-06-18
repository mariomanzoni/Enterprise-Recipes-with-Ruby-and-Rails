#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

module Spec
  module Matchers
    describe Equal do
      it "should match when actual.equal?(expected)" do
        Equal.new(1).matches?(1).should be_true
      end
      it "should not match when !actual.equal?(expected)" do
        Equal.new("1").matches?("1").should be_false
      end
      it "should describe itself" do
        matcher = Equal.new(1)
        matcher.description.should == "equal 1"
      end
      it "should provide message, expected and actual on #failure_message" do
        matcher = Equal.new("1")
        matcher.matches?(1)
        matcher.failure_message.should == ["expected \"1\", got 1 (using .equal?)", "1", 1]
      end
      it "should provide message, expected and actual on #negative_failure_message" do
        matcher = Equal.new(1)
        matcher.matches?(1)
        matcher.negative_failure_message.should == ["expected 1 not to equal 1 (using .equal?)", 1, 1]
      end
    end
  end
end
