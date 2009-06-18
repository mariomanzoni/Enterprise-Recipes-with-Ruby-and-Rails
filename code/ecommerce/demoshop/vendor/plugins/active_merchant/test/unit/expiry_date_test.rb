#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class ExpiryDateTest < Test::Unit::TestCase
  def test_should_be_expired
    last_month = 2.months.ago
    date = CreditCard::ExpiryDate.new(last_month.month, last_month.year)
    assert date.expired?
  end
  
  def test_today_should_not_be_expired
    today = Time.now
    date = CreditCard::ExpiryDate.new(today.month, today.year)
    assert_false date.expired?
  end
  
  def test_dates_in_the_future_should_not_be_expired
    next_month = 1.month.from_now
    date = CreditCard::ExpiryDate.new(next_month.month, next_month.year)
    assert_false date.expired?
  end
end