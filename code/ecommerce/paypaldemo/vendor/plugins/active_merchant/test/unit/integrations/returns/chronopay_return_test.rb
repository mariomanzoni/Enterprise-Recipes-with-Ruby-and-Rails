#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../../test_helper'

class ChronopayReturnTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def test_return
    r = Chronopay::Return.new('')
    assert r.success?
  end  
end

