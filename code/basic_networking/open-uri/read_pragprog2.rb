#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'open-uri'

result = open("http://www.pragprog.com")
if result.status[0] == '200'
  lines = result.read.split(/\n/)
  ruby_count = lines.select { |line| line =~ /Ruby/ }.size
  puts "The web site was encoded using #{result.charset}."
  puts "#{ruby_count} lines contain the word 'Ruby'."
else
  puts "We've got an unexpected result: #{result.status.join('/')}"
end


# In Ruby 1.9 we could use Array#count instead of Array#select.
