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

    class Include #:nodoc:
      
      def initialize(*expecteds)
        @expecteds = expecteds
      end
      
      def matches?(actual)
        @actual = actual
        @expecteds.each do |expected|
          return false unless actual.include?(expected)
        end
        true
      end
      
      def failure_message
        _message
      end
      
      def negative_failure_message
        _message("not ")
      end
      
      def description
        "include #{_pretty_print(@expecteds)}"
      end
      
      private
        def _message(maybe_not="")
          "expected #{@actual.inspect} #{maybe_not}to include #{_pretty_print(@expecteds)}"
        end
        
        def _pretty_print(array)
          result = ""
          array.each_with_index do |item, index|
            if index < (array.length - 2)
              result << "#{item.inspect}, "
            elsif index < (array.length - 1)
              result << "#{item.inspect} and "
            else
              result << "#{item.inspect}"
            end
          end
          result
        end
    end

    # :call-seq:
    #   should include(expected)
    #   should_not include(expected)
    #
    # Passes if actual includes expected. This works for
    # collections and Strings. You can also pass in multiple args
    # and it will only pass if all args are found in collection.
    #
    # == Examples
    #
    #   [1,2,3].should include(3)
    #   [1,2,3].should include(2,3) #would pass
    #   [1,2,3].should include(2,3,4) #would fail
    #   [1,2,3].should_not include(4)
    #   "spread".should include("read")
    #   "spread".should_not include("red")
    def include(*expected)
      Matchers::Include.new(*expected)
    end
  end
end
