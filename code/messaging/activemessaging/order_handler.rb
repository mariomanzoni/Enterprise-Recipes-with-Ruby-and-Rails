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
require 'rexml/document'

class OrderHandler
  attr_accessor :user, :password, :host, :port
  
  def initialize
    @user, @password = '', ''
    @host, @port = 'localhost', 61613
  end
  
  def handle_orders(in_queue, out_queue)
    connection = Stomp::Connection.open @user, @password, @host, @port
    connection.subscribe in_queue, { :ack => 'client' } 
    puts "Waiting for messages in #{in_queue}."
    while true
     message = connection.receive
     body = message.body
     message_id = message.headers['message-id']
     puts "Got a message: #{body} (#{message_id})"
     order_status = get_order_status(body)
     options = { 'persistent' => 'false' }
     connection.send out_queue, order_status, options
     connection.ack message_id  
    end
    connection.disconnect
  end
  
  private
  
  def get_order_status(body)
    doc = REXML::Document.new(body)
    order_id = doc.root.attributes['id']
    "<order-status id='#{order_id}'>SHIPPED</order-status>"
  end
end


if $0 == __FILE__
  
  order_handler = OrderHandler.new
  order_handler.handle_orders(
    '/queue/orders.input',
    '/queue/orders.status'
  )
  
end
