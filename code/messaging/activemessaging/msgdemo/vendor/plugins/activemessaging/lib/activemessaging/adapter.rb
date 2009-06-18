#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ActiveMessaging

  # include this module to make a new adapter - will register the adapter w/gateway so an be used in connection config
  module Adapter

    def self.included(included_by)
      class << included_by
        def register adapter_name
          Gateway.register_adapter adapter_name, self
        end
      end
    end

  end

end