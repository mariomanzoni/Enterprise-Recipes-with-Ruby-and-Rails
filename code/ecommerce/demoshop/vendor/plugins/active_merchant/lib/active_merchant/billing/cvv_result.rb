#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ActiveMerchant
  module Billing
    # Result of the Card Verification Value check
    # http://www.bbbonline.org/eExport/doc/MerchantGuide_cvv2.pdf
    # Check additional codes from cybersource website
    class CVVResult
      
      MESSAGES = {
        'D'  =>  'Suspicious transaction',
        'I'  =>  'Failed data validation check',
        'M'  =>  'Match',
        'N'  =>  'No Match',
        'P'  =>  'Not Processed',
        'S'  =>  'Should have been present',
        'U'  =>  'Issuer unable to process request',
        'X'  =>  'Card does not support verification'
      }
      
      def self.messages
        MESSAGES
      end
      
      attr_reader :code, :message
      
      def initialize(code)
        @code = code.upcase unless code.blank?
        @message = MESSAGES[@code]
      end
      
      def to_hash
        {
          'code' => code,
          'message' => message
        }
      end
    end
  end
end