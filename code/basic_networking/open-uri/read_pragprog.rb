#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'open-uri'

ruby_count = 0
options = { 'user-agent' => "Ruby/#{RUBY_VERSION}" }
open('http://www.pragprog.com', options) do |f|
  f.each_line { |line| ruby_count += 1 if line =~ /Ruby/ }
  puts f.base_uri
  puts f.content_type
  puts f.charset
  if f.content_encoding.size > 0 
    puts content_encoding.join(',')
  else
    puts 'Missing content encoding.'
  end
  puts f.last_modified || 'Missing last-modified header.'
  puts f.status.join(': ')
end
puts "#{ruby_count} lines contain the word 'Ruby'."
