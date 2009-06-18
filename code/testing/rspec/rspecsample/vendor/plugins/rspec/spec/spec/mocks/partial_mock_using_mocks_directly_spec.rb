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
describe "PartialMockUsingMocksDirectly" do
    before(:each) do
      
        klass=Class.new
        klass.class_eval do
          def existing_method
            :original_value
          end
        end
        @obj = klass.new
      
    end
    
    # See http://rubyforge.org/tracker/index.php?func=detail&aid=10263&group_id=797&atid=3149
    # specify "should clear expectations on verify" do
    #     @obj.should_receive(:msg)
    #     @obj.msg
    #     @obj.rspec_verify
    #     lambda do
    #       @obj.msg
    #     end.should raise_error(NoMethodError)
    #   
    # end
    it "should fail when expected message is not received" do
        @obj.should_receive(:msg)
        lambda do
          @obj.rspec_verify
        end.should raise_error(MockExpectationError)
      
    end
    it "should fail when message is received with incorrect args" do
        @obj.should_receive(:msg).with(:correct_arg)
        lambda do
          @obj.msg(:incorrect_arg)
        end.should raise_error(MockExpectationError)
        @obj.msg(:correct_arg)
      
    end
    it "should pass when expected message is received" do
        @obj.should_receive(:msg)
        @obj.msg
        @obj.rspec_verify
      
    end
    it "should pass when message is received with correct args" do
        @obj.should_receive(:msg).with(:correct_arg)
        @obj.msg(:correct_arg)
        @obj.rspec_verify
      
    end
    it "should revert to original method if existed" do
        @obj.existing_method.should equal(:original_value)
        @obj.should_receive(:existing_method).and_return(:mock_value)
        @obj.existing_method.should equal(:mock_value)
        @obj.rspec_verify
        @obj.existing_method.should equal(:original_value)
      
    end
  
end
end
end
