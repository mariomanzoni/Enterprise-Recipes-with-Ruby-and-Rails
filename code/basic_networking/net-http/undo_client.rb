#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'net/http'

module Net 
  class HTTP
    class Undo < HTTPRequest
      METHOD = 'UNDO'
      REQUEST_HAS_BODY = false
      RESPONSE_HAS_BODY = true
    end
  end
end 

url = URI.parse('http://localhost:4200/my-resource')
request = Net::HTTP::Undo.new(url.path) 
response = Net::HTTP.new(url.host, url.port).start do |http|
  http.request(request)
end

case response
  when Net::HTTPSuccess
    puts response.body
  else
    response.error!
end
