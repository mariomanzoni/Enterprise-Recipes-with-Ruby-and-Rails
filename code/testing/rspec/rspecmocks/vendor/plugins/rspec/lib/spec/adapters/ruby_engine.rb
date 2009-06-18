#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'spec/adapters/ruby_engine/mri'
require 'spec/adapters/ruby_engine/rubinius'

module Spec
  module Adapters
    module RubyEngine
    
      ENGINES = {
        'mri' => MRI.new,
        'rbx' => Rubinius.new
      }
    
      def self.engine
        if Object.const_defined?('RUBY_ENGINE')
          return Object.const_get('RUBY_ENGINE')
        else
          return 'mri'
        end
      end
    
      def self.adapter
        return ENGINES[engine]
      end
    end
  end
end