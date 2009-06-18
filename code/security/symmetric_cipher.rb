#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'openssl'
require 'digest/sha1'

ciphertext = 'C4whIg05mhRpyiv9BqKSIAcXZFZeb76hMU5GO/sX3LM='
cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
cipher.decrypt 
cipher.key = Digest::SHA1.hexdigest('t0p$ecret') 
cipher.iv = '1234567890abcdef' * 2 
plaintext = cipher.update(ciphertext.unpack('m*').to_s) 
plaintext << cipher.final 
puts "Plaintext: #{plaintext}"



require 'creditcard'

if plaintext.creditcard?
  puts "Credit card was issued by #{plaintext.creditcard_type}."
else
  puts 'Sorry, but this is not a credit card number.'
end



plaintext = '5431111111111111'
cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
cipher.encrypt 
cipher.key = Digest::SHA1.hexdigest('t0p$ecret')
cipher.iv = '1234567890abcdef' * 2
ciphertext = cipher.update(plaintext)
ciphertext << cipher.final
ciphertext = [ciphertext].pack('m*') 
puts "Ciphertext: #{ciphertext}"

