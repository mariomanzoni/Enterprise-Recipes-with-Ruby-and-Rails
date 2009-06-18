#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

module ActionController
  describe "Rescue", "#rescue_action in default mode" do
    before(:each) do
      @fixture = Object.new
      @fixture.extend ActionController::Rescue
      class << @fixture
        public :rescue_action
      end
    end

    it "should raise the passed in exception so examples fail fast" do
      proc {@fixture.rescue_action(RuntimeError.new("Foobar"))}.should raise_error(RuntimeError, "Foobar")
    end
  end

  class RescueOverriddenController < ActionController::Base
    def rescue_action(error)
      "successfully overridden"
    end
  end

  describe "Rescue", "#rescue_action, when overridden" do
    before(:each) do
      @fixture = RescueOverriddenController.new
    end

    it "should do whatever the overridden method does" do
      @fixture.rescue_action(RuntimeError.new("Foobar")).should == "successfully overridden"
    end
  end

  class SearchController < ActionController::Base
  end

  describe "Rescue", "#rescue_action when told to use rails error handling" do
    before(:each) do
      @controller = SearchController.new
      @controller.use_rails_error_handling!
      class << @controller
        public :rescue_action
      end
    end

    it "should use Rails exception handling" do
      exception = RuntimeError.new("The Error")
      exception.stub!(:backtrace).and_return(caller)
      @controller.should_receive(:rescue_action_locally).with(exception)

      @controller.rescue_action(exception)
    end
  end
end
