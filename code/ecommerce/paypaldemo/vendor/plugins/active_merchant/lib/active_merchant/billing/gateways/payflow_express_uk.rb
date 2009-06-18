#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/payflow_express'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PayflowExpressUkGateway < PayflowExpressGateway
      self.default_currency = 'GBP'
      self.partner = 'PayPalUk'
      
      self.supported_countries = ['GB']
      self.homepage_url = 'https://www.paypal.com/uk/cgi-bin/webscr?cmd=_additional-payment-overview-outside'
      self.display_name = 'PayPal Express Checkout (UK)'
    end
  end
end

