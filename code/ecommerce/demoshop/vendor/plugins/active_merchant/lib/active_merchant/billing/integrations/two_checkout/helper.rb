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
      module TwoCheckout
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          def initialize(order, account, options = {})
            super
            add_field('fixed', 'Y')
            
            if ActiveMerchant::Billing::Base.integration_mode == :test || options[:test]
              add_field('demo', 'Y')
            end 
          end
          
          # The 2checkout vendor account number
          mapping :account, 'sid'
          
          # he total amount to be billed, in decimal form, without a currency symbol. (8 characters, decimal, 2 characters: Example: 99999999.99)
          mapping :amount, 'total'
        
          # a unique order id from your program. (128 characters max)
          mapping :order, 'cart_order_id'


          mapping :customer, :email      => 'email',
                             :phone      => 'phone'

          mapping :billing_address, :city     => 'city',
                                    :address1 => 'street_address',
                                    :address2 => 'street_address2',
                                    :state    => 'state',
                                    :zip      => 'zip',
                                    :country  => 'country'
          
          mapping :shipping_address, :city     => 'ship_city',
                                     :address1 => 'ship_street_address',
                                     :state    => 'ship_state',
                                     :zip      => 'ship_zip',
                                     :country  => 'ship_country'
          
          mapping :invoice, 'merchant_order_id'
          
          # Does nothing, since we've disabled the Continue Shopping button by using the fixed = Y field
          mapping :return_url, 'return_url'
          
          #mapping :description, ''
          #mapping :tax, ''
          #mapping :shipping, ''
          
          def customer(params = {})
            add_field(mappings[:customer][:email], params[:email])
            add_field(mappings[:customer][:phone], params[:phone])
            add_field('card_holder_name', "#{params[:first_name]} #{params[:last_name]}")
          end
        end
      end
    end
  end
end
