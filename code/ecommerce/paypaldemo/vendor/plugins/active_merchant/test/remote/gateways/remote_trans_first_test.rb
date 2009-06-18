#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class RemoteTransFirstTest < Test::Unit::TestCase

  def setup
    @gateway = TransFirstGateway.new(fixtures(:trans_first))

    @credit_card = credit_card('4111111111111111')
    @amount = 100
    @options = { 
      :order_id => generate_unique_id,
      :invoice => 'ActiveMerchant Sale',
      :billing_address => address
    }
  end
  
  def test_successful_purchase
    assert response = @gateway.purchase(@amount, @credit_card, @options)
    assert_equal 'test transaction', response.message
    assert response.test?
    assert_success response
    assert !response.authorization.blank?
  end

  def test_invalid_login
    gateway = TransFirstGateway.new(
      :login => '',
      :password => ''
    )
    assert response = gateway.purchase(@amount, @credit_card, @options)
    assert_equal 'invalid account', response.message
    assert_failure response
  end
end
