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
    class SmartMatch
      def initialize(expected)
        @expected = expected
      end

      def matches?(actual)
        @actual = actual
        # Satisfy expectation here. Return false or raise an error if it's not met.

        if @expected =~ /^\/.*\/?$/ || @expected =~ /^".*"$/
          regex_or_string = eval(@expected)
          if Regexp === regex_or_string
            (@actual =~ regex_or_string) ? true : false
          else
            @actual.index(regex_or_string) != nil
          end
        else
          false
        end
      end

      def failure_message
        "expected #{@actual.inspect} to smart_match #{@expected.inspect}, but it didn't"
      end

      def negative_failure_message
        "expected #{@actual.inspect} not to smart_match #{@expected.inspect}, but it did"
      end
    end

    def smart_match(expected)
      SmartMatch.new(expected)
    end
  end
end