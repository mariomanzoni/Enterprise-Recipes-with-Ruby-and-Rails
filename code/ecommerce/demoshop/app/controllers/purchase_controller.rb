#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class PurchaseController < ApplicationController
  ssl_required :checkout, :purchase
  
  def checkout
    session[:order] = params[:order] 
  end
  
  def purchase
    product = session[:order][:product]
    credit_card = ActiveMerchant::Billing::CreditCard.new( 
      params[:creditcard]
    )
    total_amount = product == 'ebook' ? 2000 : 3000 
    order = Order.create(
      :product => product,
      :total_amount => total_amount
    )
    purchase = Purchase.create(
      :amount => total_amount,
      :description => "You bought: #{product}",
      :order => order,
      :completed => false
    )
    result = if product == 'ebook' 
      purchase.purchase(order, credit_card)
    else
      purchase.authorize(order, credit_card)
    end
    gateway_error(result) if !result.nil?
  end

  private
    
  def gateway_error(message)
    render :text => message
  end
end
