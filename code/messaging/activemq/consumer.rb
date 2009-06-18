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
destination = ARGV[0]
connection.subscribe destination, { :ack => 'auto' } 
puts "Waiting for messages in #{destination}."
while true  
 message = connection.receive
 message_id = message.headers['message-id']
 puts "Got a message: #{message.body} (#{message_id})"
end
connection.disconnect

