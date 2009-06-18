#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'net/https'

def create_passwords(quantity, length, options = {})
  parameters = {
    'rnd'    => 'new',
    'format' => 'plain',
    'unique' => options[:unique] ? 'on' : 'off',
    'digits' => options[:digits] ? 'on' : 'off',
    'upperalpha' => options[:upperalpha] ? 'on' : 'off',
    'loweralpha' => options[:loweralpha] ? 'on' : 'off',
    'num' => quantity.to_i,
    'len' => length.to_i
  }
  send_request(parameters)
end

def send_request(parameters)
  query = parameters.inject([]) do |l, p| 
    l << "#{p[0]}=#{p[1]}"
  end.join('&')
  https = Net::HTTP.new( 
    'www.random.org', Net::HTTP.https_default_port
  )
  https.use_ssl = true
  https.ssl_timeout = 2 
  https.verify_mode = OpenSSL::SSL::VERIFY_PEER
  https.ca_file = '/usr/share/curl/curl-ca-bundle.crt' 
  https.verify_depth = 2  
  https.enable_post_connection_check = true
  https.start do |http| 
    request  = Net::HTTP::Get.new("/strings/?#{query}")
    response = https.request(request)
    case response
    when Net::HTTPSuccess
      response.body.split(/\n/) 
    when Net::HTTPServiceUnavailable  
      []
    else
      response.error!
    end
  end
end



quantity, length = ARGV 
puts create_passwords(quantity, length, :loweralpha => true).join("\n")

