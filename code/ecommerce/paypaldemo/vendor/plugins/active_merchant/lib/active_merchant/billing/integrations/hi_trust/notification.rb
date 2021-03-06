#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module HiTrust
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          SUCCESS = '00'
          
          def complete?
            status == 'Completed'
          end 

          def transaction_id
            params['authRRN']
          end
          
          def item_id
            params['ordernumber']
          end
          
          def received_at
            Time.parse(params['orderdate']) rescue nil
          end
          
          def currency
            params['currency']
          end

          def gross
            sprintf("%.2f", gross_cents.to_f / 100)
          end
          
          def gross_cents
            params['approveamount'].to_i
          end
          
          def account
            params['storeid']
          end

          def status
            params['retcode'] == SUCCESS ? 'Completed' : 'Failed'
          end
          
          def test?
            ActiveMerchant::Billing::Base.integration_mode == :test
          end
    
          def acknowledge      
            true
          end
        end
      end
    end
  end
end
