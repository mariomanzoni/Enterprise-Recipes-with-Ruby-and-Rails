#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class EwayTest < Test::Unit::TestCase
  def setup
    Base.gateway_mode = :test
    @gateway = EwayGateway.new(fixtures(:eway))

    @credit_card_success = credit_card('4444333322221111')
    
    @credit_card_fail = credit_card('1234567812345678',
      :month => Time.now.month,
      :year => Time.now.year
    )
    
    @params = {
      :order_id => '1230123',
      :email => 'bob@testbob.com',
      :billing_address => { :address1 => '47 Bobway',
                            :city => 'Bobville',
                            :state => 'WA',
                            :country => 'AU',
                            :zip => '2000'
                          } ,
      :description => 'purchased items'
    }
  end
  
  def test_invalid_amount
    assert response = @gateway.purchase(101, @credit_card_success, @params)
    assert_failure response
    assert response.test?
    assert_equal EwayGateway::MESSAGES["01"], response.message
  end
   
  def test_purchase_success_with_verification_value 
    assert response = @gateway.purchase(100, @credit_card_success, @params)
    assert_equal '123456', response.authorization
    assert_success response
    assert response.test?
    assert_equal EwayGateway::MESSAGES["00"], response.message
  end

  def test_invalid_expiration_date
    @credit_card_success.year = 2005 
    assert response = @gateway.purchase(100, @credit_card_success, @params)
    assert_failure response
    assert response.test?
  end
  
  def test_purchase_with_invalid_verification_value
    @credit_card_success.verification_value = 'AAA' 
    assert response = @gateway.purchase(100, @credit_card_success, @params)
    assert_nil response.authorization
    assert_failure response
    assert response.test?
  end

  def test_purchase_success_without_verification_value
    @credit_card_success.verification_value = nil
    
    assert response = @gateway.purchase(100, @credit_card_success, @params)
    assert_equal '123456', response.authorization
    assert_success response
    assert response.test?
    assert_equal EwayGateway::MESSAGES["00"], response.message
  end

  def test_purchase_error
    assert response = @gateway.purchase(100, @credit_card_fail, @params)
    assert_nil response.authorization
    assert_equal false, response.success?
    assert response.test?
  end
end
