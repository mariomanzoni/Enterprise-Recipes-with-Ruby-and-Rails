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
    class PayflowResponse < Response
      def profile_id
        @params['profile_id']
      end
      
      def payment_history
        @payment_history ||= @params['rp_payment_result'].collect{ |result| result.stringify_keys } rescue []
      end
    end
  end
end