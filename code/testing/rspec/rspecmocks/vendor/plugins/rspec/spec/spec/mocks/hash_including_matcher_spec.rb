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
  module Mocks
    describe HashIncludingConstraint do
      
      it "should match the same hash" do
        hash_including(:a => 1).matches?(:a => 1).should be_true
      end
      
      it "should not match a non-hash" do
        hash_including(:a => 1).matches?(1).should_not be_true
      end

      it "should match a hash with extra stuff" do
        hash_including(:a => 1).matches?(:a => 1, :b => 2).should be_true
      end
      
      it "should not match a hash with a missing key" do
        hash_including(:a => 1).matches?(:b => 2).should_not be_true
      end

      it "should not match a hash with an incorrect value" do
        hash_including(:a => 1, :b => 2).matches?(:a => 1, :b => 3).should_not be_true
      end

      it "should describe itself properly" do
        HashIncludingConstraint.new(:a => 1).description.should == "hash_including(:a=>1)"
      end      
    end
 end
end