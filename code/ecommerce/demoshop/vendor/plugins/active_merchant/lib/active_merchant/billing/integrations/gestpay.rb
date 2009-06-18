#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# With help from Giovanni Intini and his code for RGestPay - http://medlar.it/it/progetti/rgestpay

require File.dirname(__FILE__) + '/gestpay/common.rb'
require File.dirname(__FILE__) + '/gestpay/helper.rb'
require File.dirname(__FILE__) + '/gestpay/notification.rb'
require File.dirname(__FILE__) + '/gestpay/return.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Gestpay 
       
        mattr_accessor :service_url
        self.service_url = 'https://ecomm.sella.it/gestpay/pagam.asp'

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
