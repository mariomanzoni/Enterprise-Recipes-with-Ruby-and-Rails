#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class PlugnpayTest < Test::Unit::TestCase
  def setup
    @gateway = PlugnpayGateway.new(fixtures(:plugnpay))
    @good_credit_card = credit_card('4242424242424242')
    @bad_credit_card = credit_card('1234123412341234')
    @options = {
      :billing_address => address,
      :description => 'Store purchaes'
    }
    @amount = 100
    
  end
  
  def test_bad_credit_card
    assert response = @gateway.authorize(@amount, @bad_credit_card, @options)
    assert_failure response
    assert_equal 'Invalid Credit Card No.', response.message
  end
  
  def test_good_credit_card
    assert response = @gateway.authorize(@amount, @good_credit_card, @options)
    assert_success response
    assert !response.authorization.blank?
    assert_equal 'Success', response.message
  end
  
  def test_purchase_transaction
    assert response = @gateway.purchase(@amount, @good_credit_card, @options)        
    assert_success response 
    assert !response.authorization.blank?
    assert_equal 'Success', response.message
  end
  
  # Capture, and Void require that you Whitelist your IP address.
  # In the gateway admin tool, you must add your IP address to the allowed addresses and uncheck "Remote client" under the 
  # "Auth Transactions" section of the "Security Requirements" area in the test account Security Administration Area.
  def test_authorization_and_capture
    assert authorization = @gateway.authorize(@amount, @good_credit_card, @options)
    assert_success authorization
    
    assert capture = @gateway.capture(@amount, authorization.authorization)
    assert_success capture
    assert_equal 'Success', capture.message
  end
  
  def test_authorization_and_void
    assert authorization = @gateway.authorize(@amount, @good_credit_card, @options)
    assert_success authorization
    
    assert void = @gateway.void(authorization.authorization)
    assert_success void
    assert_equal 'Success', void.message
  end
  
  def test_purchase_and_credit
    assert purchase = @gateway.purchase(@amount, @good_credit_card, @options)
    assert_success purchase
    
    assert credit = @gateway.credit(@amount, purchase.authorization)
    assert_success credit
    assert_equal 'Success', credit.message
  end
  
  def test_credit_with_no_previous_transaction
    assert credit = @gateway.credit(@amount, @good_credit_card, @options)
    
    assert_success credit
    assert_equal 'Success', credit.message
  end
end