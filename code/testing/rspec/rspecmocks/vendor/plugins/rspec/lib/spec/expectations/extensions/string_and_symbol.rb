#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Expectations
    module StringHelpers
      def starts_with?(prefix)
        to_s[0..(prefix.to_s.length - 1)] == prefix.to_s
      end
    end
  end
end

class String
  include Spec::Expectations::StringHelpers
end

class Symbol
  include Spec::Expectations::StringHelpers
end
