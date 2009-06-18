#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/authorize_net'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class SecurePayGateway < AuthorizeNetGateway
      self.live_url = self.test_url = 'https://www.securepay.com/AuthSpayAdapter/process.aspx'
      
      self.homepage_url = 'http://www.securepay.com/'
      self.display_name = 'SecurePay'
      
      # Limit support to purchase() for the time being
      # JRuby chokes here
      # undef_method :authorize, :capture, :void, :credit
      
      undef_method :authorize
      undef_method :capture
      undef_method :void
      undef_method :credit
      
      def test?
        Base.gateway_mode == :test
      end
      
      private
      def split(response)
        response.split('%')
      end
    end
  end
end

