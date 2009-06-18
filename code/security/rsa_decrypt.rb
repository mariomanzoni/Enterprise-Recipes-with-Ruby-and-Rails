#!/usr/bin/env ruby -w
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---


require 'openssl'  

ciphertext = IO.read('ciphertext.txt').unpack('m*').to_s 
password = 't0p$ecret'
private_key_data = File.read('private_key.pem')
private_key = OpenSSL::PKey::RSA.new(private_key_data, password) 
plaintext = private_key.private_decrypt(ciphertext) 
puts plaintext

