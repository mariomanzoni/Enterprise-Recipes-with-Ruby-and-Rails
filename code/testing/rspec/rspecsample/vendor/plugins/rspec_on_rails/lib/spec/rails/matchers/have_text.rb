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
    
      class HaveText  #:nodoc:

        def initialize(expected)
          @expected = expected
        end

        def matches?(response_or_text)
          @actual = response_or_text.respond_to?(:body) ? response_or_text.body : response_or_text
          return actual =~ expected if Regexp === expected
          return actual == expected unless Regexp === expected
        end
      
        def failure_message
          "expected #{expected.inspect}, got #{actual.inspect}"
        end
        
        def negative_failure_message
          "expected not to have text #{expected.inspect}"
        end
        
        def to_s
          "have text #{expected.inspect}"
        end
      
        private
          attr_reader :expected
          attr_reader :actual

      end

      # :call-seq:
      #   response.should have_text(expected)
      #   response.should_not have_text(expected)
      #
      # Accepts a String or a Regexp, matching a String using ==
      # and a Regexp using =~.
      #
      # Use this instead of <tt>response.should have_tag()</tt>
      # when you either don't know or don't care where on the page
      # this text appears.
      #
      # == Examples
      #
      #   response.should have_text("This is the expected text")
      def have_text(text)
        HaveText.new(text)
      end
    
    end
  end
end
