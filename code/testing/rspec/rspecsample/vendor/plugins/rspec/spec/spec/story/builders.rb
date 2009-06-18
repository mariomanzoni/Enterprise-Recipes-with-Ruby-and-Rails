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
    class StoryBuilder
      def initialize
        @title = 'a story'
        @narrative = 'narrative'
      end
      
      def title(value)
        @title = value
        self
      end
      
      def narrative(value)
        @narrative = value
        self
      end
      
      def to_story(&block)
        block = lambda {} unless block_given?
        Story.new @title, @narrative, &block
      end
    end
    
    class ScenarioBuilder
      def initialize
        @name = 'a scenario'
        @story = StoryBuilder.new.to_story
      end
      
      def name(value)
        @name = value
        self
      end
      
      def story(value)
        @story = value
        self
      end
      
      def to_scenario(&block)
        Scenario.new @story, @name, &block
      end
    end
  end
end
