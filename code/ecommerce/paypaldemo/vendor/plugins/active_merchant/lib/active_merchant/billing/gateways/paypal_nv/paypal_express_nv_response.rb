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
    class PaypalExpressNvResponse < Response
      def email
        @params['email']
      end

      def name
        [@params['firstname'], @params['middlename'], @params['lastname']].compact.join(' ')
      end

      def token
        @params['token']
      end

      def payer_id
        @params['payerid']
      end

      def payer_country
        @params['payer_country']
      end

      def address
        {  'name'       => self.name,
           'company'    => @params['business'],
           'address1'   => @params['shiptostreet'],
           'address2'   => @params['shiptostreet2'],
           'city'       => @params['shiptocity'],
           'state'      => @params['shiptostate'],
           'country'    => @params['shiptocountrycode'],
           'zip'        => @params['shiptozip'],
           'phone'      => @params['phonenum'],
        }
      end
    end
  end
end
