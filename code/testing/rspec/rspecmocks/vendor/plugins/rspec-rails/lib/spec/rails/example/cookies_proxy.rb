#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'action_controller/cookies'

module Spec
  module Rails
    module Example
      class CookiesProxy
        def initialize(example)
          @example = example
        end
      
        def[]=(name, value)
          @example.request.cookies[name.to_s] = CGI::Cookie.new(name.to_s, value)
        end
        
        def [](name)
          @example.response.cookies[name.to_s]
        end
      
        def delete(name)
          @example.response.cookies.delete(name.to_s)
        end
      end
    end
  end
end
