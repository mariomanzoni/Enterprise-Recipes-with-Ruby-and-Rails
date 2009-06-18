#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class RemoteSecurePayTest < Test::Unit::TestCase  
  
  def setup
    @gateway = SecurePayGateway.new(fixtures(:secure_pay))

    @credit_card = credit_card('4111111111111111',
      :month => '7',
      :year  => '2007'
    )
    
    @options = { :order_id => generate_unique_id,
      :description => 'Store purchase',
      :billing_address => address
    }
    
    @amount = 100
  end
  
  def test_successful_purchase
    assert response = @gateway.purchase(@amount, @credit_card, @options)
    assert response.success?
    assert response.test?
    assert_equal 'This transaction has been approved', response.message
    assert response.authorization
  end
end
