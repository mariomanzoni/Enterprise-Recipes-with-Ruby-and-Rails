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
      module <%= class_name %>
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          # Replace with the real mapping
          mapping :account, ''
          mapping :amount, ''
        
          mapping :order, ''

          mapping :customer, :first_name => '',
                             :last_name  => '',
                             :email      => '',
                             :phone      => ''

          mapping :billing_address, :city     => '',
                                    :address1 => '',
                                    :address2 => '',
                                    :state    => '',
                                    :zip      => '',
                                    :country  => ''

          mapping :notify_url, ''
          mapping :return_url, ''
          mapping :cancel_return_url, ''
          mapping :description, ''
          mapping :tax, ''
          mapping :shipping, ''
        end
      end
    end
  end
end
