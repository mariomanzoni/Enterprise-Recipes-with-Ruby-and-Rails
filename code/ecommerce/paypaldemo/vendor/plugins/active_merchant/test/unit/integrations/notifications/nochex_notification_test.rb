#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../../test_helper'

class NochexNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @nochex = Nochex::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @nochex.complete?
    assert_equal "Completed", @nochex.status
    assert_equal "91191", @nochex.transaction_id
    assert_equal "11", @nochex.item_id
    assert_equal "31.66", @nochex.gross
    assert_equal "GBP", @nochex.currency
    assert_equal Time.utc(2006, 9, 27, 22, 30, 53), @nochex.received_at
    assert @nochex.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'GBP'), @nochex.amount
  end

  def test_successful_acknowledgement    
    Nochex::Notification.any_instance.expects(:ssl_post).returns('AUTHORISED')
    
    assert @nochex.acknowledge
  end
  
  def test_failed_acknowledgement
    Nochex::Notification.any_instance.expects(:ssl_post).returns('DECLINED')
    
    assert !@nochex.acknowledge
  end

  def test_respond_to_acknowledge
    assert @nochex.respond_to?(:acknowledge)
  end
  
  def test_nil_notification
    Nochex::Notification.any_instance.expects(:ssl_post).returns('DECLINED')
    notification = Nochex::Notification.new(nil)
    assert !notification.acknowledge
  end

  private
  def http_raw_data
    "transaction_date=27/09/2006 22:30:53&transaction_id=91191&order_id=11&from_email=test2@nochex.com&to_email=test1@nochex.com&amount=31.66&security_key=L254524366479818252491366&status=test&custom="
  end  
end
