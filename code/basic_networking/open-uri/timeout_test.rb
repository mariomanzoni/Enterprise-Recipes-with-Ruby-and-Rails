#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'open-uri'
require 'timeout'

begin 
  timeout(2) do
    response = open('http://www.pragprog.com')
    puts response.status.join('/')
  end
rescue Timeout::Error
  puts 'The open call timed out.'
rescue => ex
  puts "An unexpected exception occurred: #{ex}."
end 
