#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class PurchaseController < ApplicationController
  PRODUCTS = {
    'rails'  => {
      :price => 4.95, :description => 'Rails Screencast'
    },
    'erlang' => {
      :price => 5.95, :description => 'Erlang Screencast'
    },
  }
  
  def express_checkout
    product = params[:order][:product]
    order = Order.create( 
      :state   => 'open',
      :product => product,
      :amount  => PRODUCTS[product][:price]
    )
    
    @response = gateway.setup_purchase( 
      amount_in_cents(order.amount),
      :ip => request.remote_ip,
      :description => PRODUCTS[order.product][:description],
      :return_url => url_for(:action => :express_checkout_complete),
      :cancel_return_url => url_for(:action => :cancel_checkout)
    )
    
    if !@response.success?
      paypal_error(@response)
    else
      paypal_token = @response.params['token'] 
      order.update_attributes(
        :paypal_token => paypal_token,
        :state => 'purchase_setup'
      )
      paypal_url = gateway.redirect_url_for(paypal_token)
      redirect_to "#{paypal_url}&useraction=commit" 
    end
  end

  private
  
  def gateway 
    @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(
      PAYPAL_API_CREDENTIALS
    )
  end

  def paypal_error(response) 
    render :text => response.message
  end
  
  def amount_in_cents(amount) 
    (amount.round(2) * 100).to_i 
  end 
end



class PurchaseController
  def express_checkout_complete
    paypal_token = params[:token]
    @order = Order.find_by_paypal_token(paypal_token) 
    @details = gateway.details_for(paypal_token)
    
    if !@details.success?
      paypal_error(@details)
    else
      logger.info "Customer name: #{@details.params['name']}"
      logger.info "Customer e-mail: #{@details.params['payer']}"
      @response = gateway.purchase( 
        amount_in_cents(@order.amount),
        :token => @details.params['token'], 
        :payer_id => @details.params['payer_id']
      )
      if !@response.success?
        paypal_error(@response)
      else
        @order.update_attribute(:state, 'closed')
        @purchase = Purchase.create(
          :amount => @response.params['gross_amount'], 
          :order => @order
        )
      end
    end
  end
end



class PurchaseController
  def cancel_checkout
    @order = Order.find_by_paypal_token(params[:token])
    @order.update_attribute(:state, 'cancelled')
  end
end

