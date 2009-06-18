#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class RemoteModernPaymentTest < Test::Unit::TestCase
  

  def setup
    @gateway = ModernPaymentsGateway.new(fixtures(:modern_payments))
    
    @amount = 100
    @credit_card = credit_card('4111111111111111')
    @declined_card = credit_card('4000000000000000')
    
    @options = { 
      :order_id => '1',
      :billing_address => address,
      :description => 'Store Purchase'
    }
  end
  
  def test_successful_purchase
    assert response = @gateway.purchase(@amount, @credit_card, @options)
    assert_success response
    assert_match /RESPONSECODE=A/, response.params["auth_string"]
    assert_equal ModernPaymentsCimGateway::SUCCESS_MESSAGE, response.message
  end

  def test_unsuccessful_purchase
    assert response = @gateway.purchase(@amount, @declined_card, @options)
    assert_success response
    assert_match /RESPONSECODE=D/, response.params["auth_string"]
    assert_equal ModernPaymentsCimGateway::SUCCESS_MESSAGE, response.message
  end

  def test_invalid_login
    gateway = ModernPaymentsGateway.new(
                :login => '',
                :password => ''
              )
    assert response = gateway.purchase(@amount, @credit_card, @options)
    assert_failure response
    assert_equal ModernPaymentsCimGateway::ERROR_MESSAGE, response.message
  end
end
