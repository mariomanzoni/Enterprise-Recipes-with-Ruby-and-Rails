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
    module CreditCardFormatting
      
      # This method is used to format numerical information pertaining to credit cards. 
      # 
      #   format(2005, :two_digits)  # => "05"
      #   format(05,   :four_digits) # => "0005"
      def format(number, option)
        return '' if number.blank?
        
        case option
          when :two_digits  ; sprintf("%.2i", number)[-2..-1]
          when :four_digits ; sprintf("%.4i", number)[-4..-1]
          else number
        end
      end
      
    end
  end
end