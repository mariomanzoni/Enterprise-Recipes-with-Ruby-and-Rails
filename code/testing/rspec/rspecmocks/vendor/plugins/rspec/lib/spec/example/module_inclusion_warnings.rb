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
    # In the future, modules will no longer be automatically included
    # in the Example Group (based on the description name); when that 
    # time comes, this code should be removed.
    module ModuleInclusionWarnings
      # Thanks, Francis Hwang.
      class MethodDispatcher
        def initialize(mod, target=nil)
          @mod = mod
          @target = target
        end
        
        def respond_to?(sym)
          @mod && @mod.instance_methods.include?(sym.to_s)
        end
        
        def call(sym, *args, &blk)
          Kernel.warn("Modules will no longer be automatically included in RSpec version 1.1.4.  Called from #{caller[2]}")
          @target.extend @mod
          @target.send(sym, *args, &blk)
        end
      end
      
      # NOTE - we don't need the second arg, but extenders do: http://www.ruby-doc.org/core/classes/Object.html#M000604
      def respond_to?(sym, include_private_data=false)
        MethodDispatcher.new(self.class.described_module).respond_to?(sym) ? true : super
      end
      
    private
      
      def method_missing(sym, *args, &blk)
        md = MethodDispatcher.new(self.class.described_module, self)
        self.respond_to?(sym) ? md.call(sym, *args, &blk) : super
      end
    end
  end
end
