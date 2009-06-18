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
    module Runner
      class ScenarioCollector
        attr_accessor :scenarios
        
        def initialize(story)
          @story = story
          @scenarios = []
        end
        
        def Scenario(name, &body)
          @scenarios << Scenario.new(@story, name, &body)
        end
      end
    end
  end
end
