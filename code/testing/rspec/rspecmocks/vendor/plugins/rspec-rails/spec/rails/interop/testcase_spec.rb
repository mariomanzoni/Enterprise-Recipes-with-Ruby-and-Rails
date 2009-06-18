#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'


if ActiveSupport.const_defined?(:Callbacks) && Test::Unit::TestCase.include?(ActiveSupport::Callbacks)

  class TestUnitTesting < Test::Unit::TestCase
    @@setup_callback_count = 0
    @@setup_method_count = 0
    @@teardown_callback_count = 0
    @@teardown_method_count = 0
    cattr_accessor :setup_callback_count, :setup_method_count, :teardown_callback_count, :teardown_method_count
    
    setup :do_some_setup
    teardown :do_some_teardown
    
    @@has_been_run = false
    def self.run?
      @@has_been_run
    end
    
    def do_some_setup
      @@setup_callback_count += 1
    end
    
    def setup
      @@setup_method_count += 1
    end
    
    def test_something
      assert_equal true, true
      @@has_been_run = true
    end
    
    def teardown
      @@teardown_method_count += 1
    end
    
    def do_some_teardown
      @@teardown_callback_count += 1
    end
  end

  module Test
    module Unit
      describe "Running TestCase tests" do
        before(:all) do
          TestUnitTesting.run unless TestUnitTesting.run?
        end
        
        it "should call the setup callbacks" do
          TestUnitTesting.setup_callback_count.should == 1
        end
        it "should still only call the normal setup method once" do
          TestUnitTesting.setup_method_count.should == 1
        end
        it "should call the teardown callbacks" do
          TestUnitTesting.teardown_callback_count.should == 1
        end
        it "should still only call the normal teardown method once" do
          TestUnitTesting.teardown_method_count.should == 1
        end
      end
    end
  end
  
end