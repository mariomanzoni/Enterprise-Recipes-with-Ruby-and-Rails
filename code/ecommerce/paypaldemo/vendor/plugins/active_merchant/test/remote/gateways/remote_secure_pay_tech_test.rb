#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class RemoteSecurePayTechTest < Test::Unit::TestCase
  $verbose = true

  def setup
    @gateway = SecurePayTechGateway.new(fixtures(:secure_pay_tech))
    
    @accepted_amount = 10000
    @declined_amount = 10075
    
    @credit_card = credit_card('4987654321098769', :month => '5', :year => '2013')
    @options = { :billing_address => address }
  end
  
  def test_successful_purchase
    assert response = @gateway.purchase(@accepted_amount, @credit_card, @options)
    assert_equal 'Transaction OK', response.message
    assert_success response
  end

  def test_unsuccessful_purchase
    assert response = @gateway.purchase(@declined_amount, @credit_card, @options)
    assert_equal 'Card declined', response.message
    assert_failure response
  end

  def test_invalid_login
    gateway = SecurePayTechGateway.new(
                :login => 'foo',
                :password => 'bar'
              )
    assert response = gateway.purchase(@accepted_amount, @credit_card, @options)
    assert_equal 'Bad or malformed request', response.message
    assert_failure response
  end
end
