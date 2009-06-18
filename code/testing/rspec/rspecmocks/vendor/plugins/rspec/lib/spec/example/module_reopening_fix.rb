#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Example
    # This is a fix for ...Something in Ruby 1.8.6??... (Someone fill in here please - Aslak)
    module ModuleReopeningFix
      def child_modules
        @child_modules ||= []
      end

      def included(mod)
        child_modules << mod
      end

      def include(mod)
        super
        child_modules.each do |child_module|
          child_module.__send__(:include, mod)
        end
      end
    end
  end
end