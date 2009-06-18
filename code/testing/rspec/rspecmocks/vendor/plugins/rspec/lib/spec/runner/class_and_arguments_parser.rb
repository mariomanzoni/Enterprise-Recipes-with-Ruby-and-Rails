#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Runner
    class ClassAndArgumentsParser
      class << self
        def parse(s)
          if s =~ /([a-zA-Z_]+(?:::[a-zA-Z_]+)*):?(.*)/
            arg = $2 == "" ? nil : $2
            [$1, arg]
          else
            raise "Couldn't parse #{s.inspect}"
          end
        end
      end
    end
  end
end