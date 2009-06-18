#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class RemoteBeanstreamInteracTest < Test::Unit::TestCase
  
  def setup
    @gateway = BeanstreamInteracGateway.new(fixtures(:beanstream_interac))
    
    @amount = 100
    
    @options = { 
      :order_id => generate_unique_id,
      :billing_address => {
        :name => 'xiaobo zzz',
        :phone => '555-555-5555',
        :address1 => '1234 Levesque St.',
        :address2 => 'Apt B',
        :city => 'Montreal',
        :state => 'QC',
        :country => 'CA',
        :zip => 'H2C1X8'
      },
      :email => 'xiaobozzz@example.com',
      :subtotal => 800,
      :shipping => 100,
      :tax1 => 100,
      :tax2 => 100,
      :custom => 'reference one'
    }
  end
  
  def test_successful_purchase
    assert response = @gateway.purchase(@amount, @options)
    assert_success response
    assert_equal "R", response.params["responseType"]
    assert_false response.redirect.blank?
  end
  
  def test_failed_confirmation
    assert response = @gateway.confirm("")
    assert_failure response
  end
  
  def test_invalid_login
    gateway = BeanstreamInteracGateway.new(
                :merchant_id => '',
                :login => '',
                :password => ''
              )
    assert response = gateway.purchase(@amount, @options)
    assert_failure response
    assert_equal 'Invalid merchant id (merchant_id = 0)', response.message
  end
end
