#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class OrderController < ApplicationController
  def ship
    order = Order.find(params[:id])
    result = order.purchase.capture(order)
    render :text => result if !result.nil?
  end
end


class OrderController < ApplicationController
  def index
  end
end
