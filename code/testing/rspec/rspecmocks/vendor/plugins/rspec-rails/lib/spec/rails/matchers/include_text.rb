#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Rails
    module Matchers

      class IncludeText  #:nodoc:

        def initialize(expected)
          @expected = expected
        end

        def matches?(response_or_text)
          @actual = response_or_text.respond_to?(:body) ? response_or_text.body : response_or_text
          return actual.include?(expected)
        end

        def failure_message
          "expected to find #{expected.inspect} in #{actual.inspect}"
        end

        def negative_failure_message
          "expected not to include text #{expected.inspect}"
        end

        def to_s
          "include text #{expected.inspect}"
        end

        private
          attr_reader :expected
          attr_reader :actual

      end


      # :call-seq:
      #   response.should include_text(expected)
      #   response.should_not include_text(expected)
      #
      # Accepts a String, matching using include?
      #
      # Use this instead of <tt>response.should have_text()</tt>
      # when you either don't know or don't care where on the page
      # this text appears.
      #
      # == Examples
      #
      #   response.should include_text("This text will be in the actual string")
      def include_text(text)
        IncludeText.new(text)
      end

    end
  end
end