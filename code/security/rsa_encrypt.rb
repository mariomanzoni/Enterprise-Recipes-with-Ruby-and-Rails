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
  
plaintext = 'Hello, world!'
public_key = OpenSSL::PKey::RSA.new(IO::read('public_key.pem')) 
ciphertext = public_key.public_encrypt(plaintext) 
puts "Ciphertext length is #{ciphertext.length} bytes."
puts [ciphertext].pack('m*') 

