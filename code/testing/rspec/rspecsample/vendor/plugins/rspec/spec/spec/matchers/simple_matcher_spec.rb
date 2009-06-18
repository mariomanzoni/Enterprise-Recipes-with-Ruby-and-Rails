#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

module Spec
  module Matchers
    describe SimpleMatcher do
      it "should match pass match arg to block" do
        actual = nil
        matcher = simple_matcher("message") do |given| actual = given end
        matcher.matches?("foo")
        actual.should == "foo"
      end
      
      it "should provide a stock failure message" do
        matcher = simple_matcher("thing") do end
        matcher.matches?("other")
        matcher.failure_message.should =~ /expected \"thing\" but got \"other\"/
      end
      
      it "should provide a stock negative failure message" do
        matcher = simple_matcher("thing") do end
        matcher.matches?("other")
        matcher.negative_failure_message.should =~ /expected not to get \"thing\", but got \"other\"/
      end
      
      it "should provide a description" do
        matcher = simple_matcher("thing") do end
        matcher.description.should =="thing"
      end
    end
  end
end