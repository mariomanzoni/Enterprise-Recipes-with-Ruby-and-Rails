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
    module Example
      class AssignsHashProxy #:nodoc:
        def initialize(object)
          @object = object
        end

        def [](ivar)
          if assigns.include?(ivar.to_s)
            assigns[ivar.to_s]
          elsif assigns.include?(ivar)
            assigns[ivar]
          else
            nil
          end
        end

        def []=(ivar, val)
          assigns[ivar.to_s] = val
        end

        def delete(name)
          assigns.delete(name.to_s)
        end

        def each(&block)
          assigns.each &block
        end

        def has_key?(key)
          assigns.key?(key.to_s)
        end

        protected
        def assigns
          @object.assigns
        end
      end
    end
  end
end
