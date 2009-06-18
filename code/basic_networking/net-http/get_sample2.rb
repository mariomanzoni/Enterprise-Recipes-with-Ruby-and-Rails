#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'net/http'

url = URI.parse('http://www.ietf.org/rfc/rfc2616.txt')
request = Net::HTTP::Get.new(url.path) 
response = Net::HTTP.start(url.host, url.port) do |http|
  http.request(request) 
end
puts response.body
