#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class BogusModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def test_notification_method
    assert_instance_of Bogus::Notification, Bogus.notification('name=cody')
  end

  def test_service_url
    new = 'http://www.unbogus.com'
    assert_equal 'http://www.bogus.com', Bogus.service_url
    Bogus.service_url = new
    assert_equal new, Bogus.service_url
  end
  
  def test_return_method
    assert_instance_of Bogus::Return, Bogus.return('name=cody')
  end
end 
