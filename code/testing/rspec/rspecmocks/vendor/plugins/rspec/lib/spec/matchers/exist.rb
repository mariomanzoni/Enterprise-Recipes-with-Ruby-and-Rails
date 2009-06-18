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
    class Exist
      def matches? actual
        @actual = actual
        @actual.exist?
      end
      def failure_message
        "expected #{@actual.inspect} to exist, but it doesn't."
      end
      def negative_failure_message
        "expected #{@actual.inspect} to not exist, but it does."
      end
    end
    def exist; Exist.new; end
  end
end
