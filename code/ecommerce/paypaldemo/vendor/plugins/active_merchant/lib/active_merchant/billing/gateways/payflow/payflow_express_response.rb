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
    class PayflowExpressResponse < Response
      def email
        @params['e_mail']
      end
      
      def full_name
        "#{@params['name']} #{@params['lastname']}"
      end
      
      def token
        @params['token']
      end
      
      def payer_id
        @params['payer_id']
      end
      
      # Really the shipping country, but it is all the information provided
      def payer_country
        address['country']
      end
      
      def address
        {  'name'       => full_name,
           'company'    => nil,
           'address1'   => @params['street'],
           'address2'   => nil,
           'city'       => @params['city'],
           'state'      => @params['state'],
           'country'    => @params['country'],
           'zip'        => @params['zip'],
           'phone'      => nil
        }
      end
    end
  end
end