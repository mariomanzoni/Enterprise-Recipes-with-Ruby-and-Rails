#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'stomp'

user, password = '', ''
host, port = 'localhost', 61613
connection = Stomp::Connection.open(user, password, host, port)
p connection
destination = 'testqueue@router1'
connection.subscribe destination, { :ack => 'auto' }
while true 
 message = connection.receive
 if message
    puts message.body
  else
    puts "Got no message!"
  end
end
connection.disconnect
