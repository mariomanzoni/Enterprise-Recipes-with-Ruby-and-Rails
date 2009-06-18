#!/usr/bin/env ruby -w
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---


require 'date'
require 'flrfile'

parser = FLR.new(File.new(ARGV[0]), [5, 6, 44, 40]) 
parser.each do |row|
  amount = row[0].to_f / 100
  valid_to = Date.parse(row[1][0, 2] + '/' + row[1][2, 4]) >> 1
  number, holder = row[2], row[3]
  puts "Charge #{amount} from #{holder}."
  puts "Credit card: #{number}"
end


require 'rubygems'
require 'openssl'
require 'digest/sha1'
require 'base64'
require 'creditcard'

def decrypt(ciphertext)
  cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  cipher.decrypt
  cipher.key = Digest::SHA1.hexdigest('t0p$ecret')
  cipher.iv = '1234567890abcdef'
  plaintext = cipher.update(Base64.decode64(ciphertext))
  plaintext << cipher.final
end

parser = FLR.new(File.new(ARGV[0]), [5, 6, 44, 40])
parser.each do |row|
  amount = row[0].to_f / 100
  number, holder = decrypt(row[2]), row[3]
  if number.creditcard?
    puts "#{holder}: #{number} (#{number.creditcard_type})"
  end
end
