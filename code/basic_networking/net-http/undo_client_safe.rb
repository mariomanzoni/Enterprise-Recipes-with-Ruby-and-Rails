#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'net/https'

module Net
  class HTTP
    class Undo < HTTPRequest
      METHOD = 'UNDO'
      REQUEST_HAS_BODY = false
      RESPONSE_HAS_BODY = true
    end
  end
end

proxy_host = nil
proxy_port = nil
proxy_user = nil
proxy_pass = nil


require 'net/https'
proxy = Net::HTTP::Proxy(
  proxy_host, proxy_port, proxy_user, proxy_pass
)
connection = proxy.new('localhost', 4200) 
connection.use_ssl = true
connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Undo.new('/my-resource')
request.basic_auth 'maik', 't0p$secret' 
response = connection.request(request)
puts response.body

