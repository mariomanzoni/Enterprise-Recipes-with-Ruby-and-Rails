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
    
    class Has #:nodoc:
      def initialize(sym, *args)
        @sym = sym
        @args = args
      end
      
      def matches?(target)
        target.__send__(predicate, *@args)
      end
      
      def failure_message
        "expected ##{predicate}(#{@args[0].inspect}) to return true, got false"
      end
      
      def negative_failure_message
        "expected ##{predicate}(#{@args[0].inspect}) to return false, got true"
      end
      
      def description
        "have key #{@args[0].inspect}"
      end
      
      private
        def predicate
          "#{@sym.to_s.sub("have_","has_")}?".to_sym
        end
        
    end
 
  end
end
