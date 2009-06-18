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
      module Gestpay
        module Common
          VERSION = "2.0"
          ENCRYPTION_PATH = "/CryptHTTPS/Encrypt.asp"
          DECRYPTION_PATH = "/CryptHTTPS/Decrypt.asp"
          DELIMITER = '*P1*'
          
          CURRENCY_MAPPING = {
            'EUR' => '242',
            'ITL' => '18',
            'BRL' => '234',
            'USD' => '1',
            'JPY' => '71',
            'HKD' => '103'
          }
          
          def parse_response(response)
            case response
            when /#cryptstring#(.*)#\/cryptstring#/, /#decryptstring#(.*)#\/decryptstring#/
              $1
            when /#error#(.*)#\/error#/
              raise StandardError, "An error occurred retrieving the encrypted string from GestPay: #{$1}"
            else
              raise StandardError, "No response was received by GestPay"
            end
          end
          
          def ssl_get(url, path)
            uri = URI.parse(url)
            site = Net::HTTP.new(uri.host, uri.port)
            site.use_ssl = true
            site.verify_mode    = OpenSSL::SSL::VERIFY_NONE
            site.get(path).body
          end
        end
      end
    end
  end
end