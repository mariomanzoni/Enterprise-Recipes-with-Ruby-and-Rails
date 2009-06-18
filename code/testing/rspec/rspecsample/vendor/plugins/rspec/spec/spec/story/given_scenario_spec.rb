#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/story_helper'

module Spec
  module Story
    describe GivenScenario do
      it 'should execute a scenario from the current story in its world' do
        # given
        class MyWorld
          attr :scenario_ran
        end
        instance = World.create(MyWorld)
        scenario = ScenarioBuilder.new.to_scenario do
          @scenario_ran = true
        end
        Runner::StoryRunner.should_receive(:scenario_from_current_story).with('scenario name').and_return(scenario)
        
        step = GivenScenario.new 'scenario name'
        
        # when
        step.perform(instance, nil)
        
        # then
        instance.scenario_ran.should be_true
      end
    end
  end
end
