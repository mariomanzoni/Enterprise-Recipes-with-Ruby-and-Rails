#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class CreditCardFormattingTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::CreditCardFormatting
  
  def test_should_format_number_by_rule
    assert_equal 2005, format(2005, :steven_colbert)
    
    assert_equal '0005', format(05, :four_digits)
    assert_equal '2005', format(2005, :four_digits)
    
    assert_equal '05', format(2005, :two_digits)
    assert_equal '05', format(05, :two_digits)
    assert_equal '08', format(8, :two_digits)
    
    assert format(nil, :two_digits).blank?
    assert format('', :two_digits).blank?
  end
end
