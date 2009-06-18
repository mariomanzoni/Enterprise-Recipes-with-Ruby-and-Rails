#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'socket'

class ServiceInfoClient
  def initialize(port, host = 'localhost')
    @port, @host = port, host
  end
  
  def get_service_info(name)
    socket = TCPSocket.open(@host, @port) 
    socket.write("info #{name}\n")
    service_info = socket.read
    socket.close 
    lines = service_info.split(/\n/)
    status = lines.shift
    raise status unless status == 'OK'
    lines.inject({}) do |result, line|
      key, value = line.chomp.split(':')
      result[key] = value.strip
      result
    end
  end
end


if $0 == __FILE__
  
  require 'pp'
  client = ServiceInfoClient.new(12345)
  pp client.get_service_info('order')
  
end
