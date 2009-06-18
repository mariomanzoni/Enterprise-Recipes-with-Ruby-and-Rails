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

    class BeClose #:nodoc:
      def initialize(expected, delta)
        @expected = expected
        @delta = delta
      end
      
      def matches?(actual)
        @actual = actual
        (@actual - @expected).abs < @delta
      end
      
      def failure_message
        "expected #{@expected} +/- (< #{@delta}), got #{@actual}"
      end
      
      def description
        "be close to #{@expected} (within +- #{@delta})"
      end
    end
    
    # :call-seq:
    #   should be_close(expected, delta)
    #   should_not be_close(expected, delta)
    #
    # Passes if actual == expected +/- delta
    #
    # == Example
    #
    #   result.should be_close(3.0, 0.5)
    def be_close(expected, delta)
      Matchers::BeClose.new(expected, delta)
    end
  end
end
