#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'net/http'
require 'hpricot'

response = Net::HTTP.post_form(
  URI.parse('http://www.pragprog.com/search'),
  { 'q' => 'Enterprise' }
)

case response 
  when Net::HTTPSuccess
    puts 'Your search succeeded.'
    doc = Hpricot(response.body)
    (doc/'//a').each { |a| puts a.attributes['href'] }
  when Net::HTTPRedirection
    puts "The search form has moved to #{response['location']}."
  else
    response.error!
end

