#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class PayflowUkTest < Test::Unit::TestCase
  def setup
    @gateway = PayflowUkGateway.new(
      :login => 'LOGIN',
      :password => 'PASSWORD'
    )
  end

  def test_default_currency
    assert_equal 'GBP', PayflowUkGateway.default_currency
  end
  
  def test_express_instance
    assert_instance_of PayflowExpressUkGateway, @gateway.express
  end
  
  def test_default_partner
    assert_equal 'PayPalUk', PayflowUkGateway.partner
  end
  
  def test_supported_countries
    assert_equal ['GB'], PayflowUkGateway.supported_countries
  end
  
  def test_supported_card_types
    assert_equal [:visa, :master, :american_express, :discover, :solo, :switch], PayflowUkGateway.supported_cardtypes
  end
end
