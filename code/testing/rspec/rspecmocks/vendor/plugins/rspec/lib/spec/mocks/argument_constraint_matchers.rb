#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Mocks
    module ArgumentConstraintMatchers
      
      # Shortcut for creating an instance of Spec::Mocks::DuckTypeArgConstraint
      def duck_type(*args)
        DuckTypeArgConstraint.new(*args)
      end

      def any_args
        AnyArgsConstraint.new
      end
      
      def anything
        AnyArgConstraint.new(nil)
      end
      
      def boolean
        BooleanArgConstraint.new(nil)
      end
      
      def hash_including(expected={})
        HashIncludingConstraint.new(expected)
      end
      
      def no_args
        NoArgsConstraint.new
      end
    end
  end
end
