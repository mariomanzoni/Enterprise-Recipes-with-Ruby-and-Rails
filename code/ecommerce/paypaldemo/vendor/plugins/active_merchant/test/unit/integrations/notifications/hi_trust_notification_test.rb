#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../../test_helper'

class HiTrustNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @notification = HiTrust::Notification.new(successful_response)
  end

  def test_accessors
    assert @notification.complete?
    assert_equal "Completed", @notification.status
    assert_equal "012345678901", @notification.transaction_id
    assert_equal "1000", @notification.item_id
    assert_equal "101010", @notification.account
    assert_equal "5.00", @notification.gross
    assert_equal "USD", @notification.currency
    assert_equal Time.parse("2007-12-01.12.35.40.123456"), @notification.received_at
    assert @notification.test?
  end

  def test_compositions
    assert_equal Money.new(500, 'USD'), @notification.amount
  end

  def test_send_acknowledgement
    assert @notification.acknowledge
  end

  def test_respond_to_acknowledge
    assert @notification.respond_to?(:acknowledge)
  end

  private
  def successful_response
    'retcode=00&ordernumber=1000&orderstatus=02&authCode=123456&eci=VISA3D&authRRN=012345678901&storeid=101010&approveamount=500&currency=USD&orderdate=2007-12-01.12.35.40.123456'
  end  
end
