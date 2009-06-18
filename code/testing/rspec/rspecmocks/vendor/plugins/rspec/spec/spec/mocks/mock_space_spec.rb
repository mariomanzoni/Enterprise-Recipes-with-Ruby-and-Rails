#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'
require 'spec/mocks'

module Spec
  module Mocks
    describe Space do
      before :each do
        @space = Space.new
        klazz = Class.new do
          def rspec_verify
            @verified = true
          end
          def verified?
            @verified
          end
          def rspec_reset
            @reset = true
          end
          def reset?
            @reset
          end
        end
        @m1 = klazz.new
        @m2 = klazz.new
      end
      it "should verify all mocks within" do
        @space.add(@m1)
        @space.add(@m2)
        @space.verify_all
        @m1.should be_verified
        @m2.should be_verified
      end
      it "should reset all mocks within" do
        @space.add(m1 = mock("mock1"))
        @space.add(m2 = mock("mock2"))
        m1.should_receive(:rspec_reset)
        m2.should_receive(:rspec_reset)
        @space.reset_all
      end
      it "should clear internal mocks on reset_all" do
        @space.add(m = mock("mock"))
        @space.reset_all
        @space.instance_eval { mocks.empty? }.should be_true
      end
      it "should only add an instance once" do
        @space.add(m1 = mock("mock1"))
        @space.add(m1)
        m1.should_receive(:rspec_verify)
        @space.verify_all
      end
    end
  end
end
    
