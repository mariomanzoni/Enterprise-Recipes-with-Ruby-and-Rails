#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rexml/document'

class OrderStatusProcessor < ApplicationProcessor
  subscribes_to :order_status 

  def on_message(message)
    doc = REXML::Document.new(message)
    order_id = doc.root.attributes['id']
    order_status = doc.root.text
    order = Order.find(order_id)
    order.status = order_status
    order.save
    logger.debug "Status of order #{order_id} is #{order_status}."
  end
end
