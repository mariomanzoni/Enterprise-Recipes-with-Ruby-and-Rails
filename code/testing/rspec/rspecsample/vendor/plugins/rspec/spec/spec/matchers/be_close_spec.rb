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
    describe BeClose do
      it "should match when value == target" do
        BeClose.new(5.0, 0.5).matches?(5.0).should be_true
      end
      it "should match when value < (target + delta)" do
        BeClose.new(5.0, 0.5).matches?(5.49).should be_true
      end
      it "should match when value > (target - delta)" do
        BeClose.new(5.0, 0.5).matches?(4.51).should be_true
      end
      it "should not match when value == (target - delta)" do
        BeClose.new(5.0, 0.5).matches?(4.5).should be_false
      end
      it "should not match when value < (target - delta)" do
        BeClose.new(5.0, 0.5).matches?(4.49).should be_false
      end
      it "should not match when value == (target + delta)" do
        BeClose.new(5.0, 0.5).matches?(5.5).should be_false
      end
      it "should not match when value > (target + delta)" do
        BeClose.new(5.0, 0.5).matches?(5.51).should be_false
      end
      it "should provide a useful failure message" do
        #given
          matcher = BeClose.new(5.0, 0.5)
        #when
          matcher.matches?(5.51)
        #then
          matcher.failure_message.should == "expected 5.0 +/- (< 0.5), got 5.51"
      end
      it "should describe itself" do
        BeClose.new(5.0, 0.5).description.should == "be close to 5.0 (within +- 0.5)"
      end
    end
  end
end
