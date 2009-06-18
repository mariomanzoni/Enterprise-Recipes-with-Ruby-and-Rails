#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      class Return
        attr_accessor :params
      
        def initialize(query_string)
          @params = parse(query_string)
        end
      
        # Successful by default. Overridden in the child class
        def success?
          true
        end
      
        def message
          
        end
        
        def parse(query_string)
          return {} if query_string.blank?
          
          query_string.split('&').inject({}) do |memo, chunk|
            next if chunk.empty?
            key, value = chunk.split('=', 2)
            next if key.empty?
            value = value.nil? ? nil : CGI.unescape(value)
            memo[CGI.unescape(key)] = value
            memo
          end
        end 
      end
    end
  end
end
