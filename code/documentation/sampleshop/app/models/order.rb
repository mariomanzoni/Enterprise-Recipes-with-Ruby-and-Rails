#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# This class encapsulates all attributes of an order. In addition, it
# provides some methods for calculating various figures.
class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :line_items
  
  # Calculates the total amount of an order.
  def total_amount()
    self.line_items.inject(0) { |total, li| total += li.total_price }
  end
  
  # Calculates the payment amount of an order.
  #
  # discount:: 
  #  Discount (percentage) that will be granted to the customer.
  # This method still has some *problems*: 
  # * It does not check if discount is negative.
  # * It does not check if discount is greater than 100.
  def payment_amount(discount = 0)
    total_amount() * (1 - discount / 100)
  end
end
