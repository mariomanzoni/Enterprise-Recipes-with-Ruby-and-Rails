#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Story
    class StepMother
      def initialize
        @steps = StepGroup.new
      end
      
      def use(new_step_group)
        @steps << new_step_group
      end
      
      def store(type, step)
        @steps.add(type, step)
      end
      
      def find(type, name)
        if @steps.find(type, name).nil?
          @steps.add(type,
          Step.new(name) do
            raise Spec::Example::ExamplePendingError.new("Unimplemented step: #{name}")
          end
          )
        end
        @steps.find(type, name)
      end
      
      def clear
        @steps.clear
      end
      
      def empty?
        @steps.empty?
      end
      
    end
  end
end
