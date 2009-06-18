#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'active_merchant/billing/integrations/paypal/helper.rb'
require 'active_merchant/billing/integrations/paypal/notification.rb'
require 'active_merchant/billing/integrations/paypal/return.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Paypal
        
        # Overwrite this if you want to change the Paypal test url
        mattr_accessor :test_url
        self.test_url = 'https://www.sandbox.paypal.com/cgi-bin/webscr'
        
        # Overwrite this if you want to change the Paypal production url
        mattr_accessor :production_url 
        self.production_url = 'https://www.paypal.com/cgi-bin/webscr' 
        
        def self.service_url
          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
          when :production
            self.production_url    
          when :test
            self.test_url
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end
            
        def self.notification(post)
          Notification.new(post)
        end
        
        def self.return(query_string)
          Return.new(query_string)
        end
      end
    end
  end
end
