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
    class PayflowNvResponse < Response
      def profile_id
        @params['profileid']
      end

      def payment_history
        @payment_history ||= get_history
      end
      protected
      def get_history
        hist = []
        @params.reject {|key,val| key !~ /p_result/}.collect {|r| r[0].gsub(/p_result/, "")}.sort.each do |idx|
          item = {
            'payment_num' => "#{idx}",
            'amt' => @params["p_amt#{idx}"],
            'transtime' => @params["p_transtime#{idx}"],
            'result' => @params["p_result#{idx}"],
            'state' => @params["p_transtate#{idx}"],
          }
          hist << item
        end
        return hist
      end
    end
  end
end
