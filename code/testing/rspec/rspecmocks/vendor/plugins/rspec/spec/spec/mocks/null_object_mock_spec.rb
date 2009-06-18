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
    describe "a mock acting as a NullObject" do
      before(:each) do
        @mock = Mock.new("null_object", :null_object => true)
      end

      it "should allow explicit expectation" do
        @mock.should_receive(:something)
        @mock.something
      end

      it "should fail verification when explicit exception not met" do
        lambda do
          @mock.should_receive(:something)
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should ignore unexpected methods" do
        @mock.random_call("a", "d", "c")
        @mock.rspec_verify
      end

      it "should expected message with different args first" do
        @mock.should_receive(:message).with(:expected_arg)
        @mock.message(:unexpected_arg)
        @mock.message(:expected_arg)
      end

      it "should expected message with different args second" do
        @mock.should_receive(:message).with(:expected_arg)
        @mock.message(:expected_arg)
        @mock.message(:unexpected_arg)
      end
    end
  end
end
