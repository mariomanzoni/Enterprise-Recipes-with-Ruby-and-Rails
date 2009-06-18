#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Story
    class GivenScenario
      def initialize(name)
        @name = name
      end
      
      def perform(instance, ignore_name)
        scenario = Runner::StoryRunner.scenario_from_current_story(@name)
        Runner::ScenarioRunner.new.run(scenario, instance)
      end
    end
  end
end
