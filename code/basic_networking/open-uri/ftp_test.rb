#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'open-uri'
require 'digest/md5'

filename = 'ruby-1.8.6-p111.tar.gz'
response = open("ftp://ftp.ruby-lang.org/pub/ruby/1.8/#{filename}")
content = response.read
digest = Digest::MD5.hexdigest(content)
if digest != 'c36e011733a3a3be6f43ba27b7cd7485'
  puts "Wrong digest: #{digest}!"
else
  puts 'Everything is fine!'
  File.open(filename, 'wb') { |f| f.write(content) }
end
