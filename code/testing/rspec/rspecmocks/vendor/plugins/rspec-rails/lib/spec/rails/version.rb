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
    module VERSION #:nodoc:
      unless defined? MAJOR
        MAJOR  = 1
        MINOR  = 1
        TINY   = 4

        STRING = [MAJOR, MINOR, TINY].join('.')

        SUMMARY = "rspec-rails version #{STRING}"
      end
    end
  end
end