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
    
    class RespondTo #:nodoc:
      def initialize(*names)
        @names = names
        @names_not_responded_to = []
      end
      
      def matches?(target)
        @names.each do |name|
          unless target.respond_to?(name)
            @names_not_responded_to << name
          end
        end
        return @names_not_responded_to.empty?
      end
      
      def failure_message
        "expected target to respond to #{@names_not_responded_to.collect {|name| name.inspect }.join(', ')}"
      end
      
      def negative_failure_message
        "expected target not to respond to #{@names.collect {|name| name.inspect }.join(', ')}"
      end
      
      def description
        "respond to ##{@names.to_s}"
      end
    end
    
    # :call-seq:
    #   should respond_to(*names)
    #   should_not respond_to(*names)
    #
    # Matches if the target object responds to all of the names
    # provided. Names can be Strings or Symbols.
    #
    # == Examples
    # 
    def respond_to(*names)
      Matchers::RespondTo.new(*names)
    end
  end
end
