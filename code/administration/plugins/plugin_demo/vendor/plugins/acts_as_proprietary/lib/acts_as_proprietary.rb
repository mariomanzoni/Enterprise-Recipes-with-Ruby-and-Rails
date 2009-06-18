#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module EnterprisePlugin
  module Acts
    module Proprietary
      def self.included(base) 
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_proprietary(options = {})
          cattr_accessor :sort_attributes
          self.sort_attributes = options[:sort_attributes] || false
          include InstanceMethods
          extend SingletonMethods
        end
      end

      # This module contains instance methods.
      module InstanceMethods
        def dump
          result = "Model:#{self.class.name}\n"
          keys = attributes.keys
          keys.sort! if self.sort_attributes          
          keys.each { |key| result << "#{key}:#{attributes[key]}\n" }
          result
        end
      end

      # This module contains class methods.
      module SingletonMethods
      end
    end
  end
end
