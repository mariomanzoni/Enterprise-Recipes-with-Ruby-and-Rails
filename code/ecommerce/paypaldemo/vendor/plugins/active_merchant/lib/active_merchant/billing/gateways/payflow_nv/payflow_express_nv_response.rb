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
    class PayflowExpressNvResponse < Response
      def email
        @params['email']
      end

      def full_name
        "#{@params['firstname']} #{@params['lastname']}"
      end

      def token
        @params['token']
      end

      def payer_id
        @params['payerid']
      end

      # Really the shipping country, but it is all the information provided
      def payer_country
        address['country']
      end

      def address
        {  'name'       => full_name,
           'company'    => @params['business'],
           'address1'   => @params['shiptostreet'],
           'address2'   => nil,
           'city'       => @params['shiptocity'],
           'state'      => @params['shiptostate'],
           'country'    => @params['shiptocountry'],
           'zip'        => @params['shiptozip'],
           'phone'      => nil
        }
      end
    end
  end
end
