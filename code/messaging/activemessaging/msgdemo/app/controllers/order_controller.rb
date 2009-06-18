#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'activemessaging/processor'

class OrderController < ApplicationController
  include ActiveMessaging::MessageSender
  
  publishes_to :order 
  
  def add
    order = Order.new(params[:order])
    if request.post? and order.save
      flash.now[:notice] = 'Order has been submitted.'
      publish :order, order.to_xml 
      redirect_to :action => 'show_status', :id => order.id
    end
  end

  def show_status
    @order = Order.find(params[:id])
  end
end
