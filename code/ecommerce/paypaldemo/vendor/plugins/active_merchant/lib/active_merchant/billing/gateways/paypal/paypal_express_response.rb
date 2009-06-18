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
    class PaypalExpressResponse < Response
      def email
        @params['payer']
      end
      
      def name
        [@params['first_name'], @params['middle_name'], @params['last_name']].compact.join(' ')
      end
      
      def token
        @params['token']
      end
      
      def payer_id
        @params['payer_id']
      end
      
      def payer_country
        @params['payer_country']
      end
      
      def address
        {  'name'       => @params['name'],
           'company'    => @params['payer_business'],
           'address1'   => @params['street1'],
           'address2'   => @params['street2'],
           'city'       => @params['city_name'],
           'state'      => @params['state_or_province'],
           'country'    => @params['country'],
           'zip'        => @params['postal_code'],
           'phone'      => nil
        }
      end
    end
  end
end