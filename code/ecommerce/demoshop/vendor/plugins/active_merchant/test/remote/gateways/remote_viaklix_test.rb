#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class RemoteViaklixTest < Test::Unit::TestCase
  def setup
    @gateway = ViaklixGateway.new(fixtures(:viaklix))
    
    @credit_card = credit_card    
    @bad_credit_card = credit_card('invalid')
    
    @options = {
      :order_id => '#1000.1',
      :email => "paul@domain.com",   
      :description => 'Test Transaction',
      :billing_address => address
    }
    @amount = 100
  end
  
  def test_successful_purchase
    assert response = @gateway.purchase(@amount, @credit_card, @options)
    
    assert_success response
    assert response.test?
    assert_equal 'APPROVED', response.message
    assert response.authorization
  end
  
  def test_failed_purchase
    assert response = @gateway.purchase(@amount, @bad_credit_card, @options)
  
    assert_failure response
    assert response.test?
    assert_equal 'The Credit Card Number supplied in the authorization request appears invalid.', response.message
  end
  
  def test_credit
    assert purchase = @gateway.purchase(@amount, @credit_card, @options)
    assert_success purchase
    
    assert credit = @gateway.credit(@amount, @credit_card)
    assert_success credit
  end
end