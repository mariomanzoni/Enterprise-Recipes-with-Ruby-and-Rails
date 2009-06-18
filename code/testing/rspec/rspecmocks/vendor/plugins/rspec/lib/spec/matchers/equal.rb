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
  
    class Equal #:nodoc:
      def initialize(expected)
        @expected = expected
      end
  
      def matches?(actual)
        @actual = actual
        @actual.equal?(@expected)
      end

      def failure_message
        return "expected #{@expected.inspect}, got #{@actual.inspect} (using .equal?)", @expected, @actual
      end

      def negative_failure_message
        return "expected #{@actual.inspect} not to equal #{@expected.inspect} (using .equal?)", @expected, @actual
      end
      
      def description
        "equal #{@expected.inspect}"
      end
    end
    
    # :call-seq:
    #   should equal(expected)
    #   should_not equal(expected)
    #
    # Passes if actual and expected are the same object (object identity).
    #
    # See http://www.ruby-doc.org/core/classes/Object.html#M001057 for more information about equality in Ruby.
    #
    # == Examples
    #
    #   5.should equal(5) #Fixnums are equal
    #   "5".should_not equal("5") #Strings that look the same are not the same object
    def equal(expected)
      Matchers::Equal.new(expected)
    end
  end
end
