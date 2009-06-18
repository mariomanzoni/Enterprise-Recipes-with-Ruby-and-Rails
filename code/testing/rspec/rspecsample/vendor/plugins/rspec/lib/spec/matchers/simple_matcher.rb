#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Matchers
    class SimpleMatcher
      attr_reader :description
      
      def initialize(description, &match_block)
        @description = description
        @match_block = match_block
      end

      def matches?(actual)
        @actual = actual
        return @match_block.call(@actual)
      end

      def failure_message()
        return %[expected #{@description.inspect} but got #{@actual.inspect}]
      end
        
      def negative_failure_message()
        return %[expected not to get #{@description.inspect}, but got #{@actual.inspect}]
      end
    end
    
    def simple_matcher(message, &match_block)
      SimpleMatcher.new(message, &match_block)
    end
  end
end