#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class Purchase < ActiveRecord::Base
  belongs_to :order
  
  def purchase(order, credit_card)
    response = gateway.purchase(
      order.total_amount, credit_card,
      :description => self.description
    )
    return response.message if !response.success?
    self.xaction_id = response.authorization
    self.completed = true 
    save
    nil
  end
  
  def authorize(order, credit_card)
    response = gateway.authorize(
      order.total_amount, credit_card,
      :description => self.description
    )
    self.xaction_id = response.authorization 
    self.completed = false
    save
    response.success? ? nil : response.message
  end
  
  def capture(order)
    unless self.completed 
      response = gateway.capture(order.total_amount, self.xaction_id)
      return response.message if !response.success?
      self.completed = true
      save
    end
    nil
  end
  
  private
  
  def gateway
    @gateway ||= ActiveMerchant::Billing::BraintreeGateway.new(
      :login => 'demo', :password => 'password'
    ) 
  end
end
