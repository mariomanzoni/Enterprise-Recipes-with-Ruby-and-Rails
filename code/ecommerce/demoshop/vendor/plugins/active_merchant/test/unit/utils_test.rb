#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class UtilsTest < Test::Unit::TestCase
  def test_unique_id_should_be_32_chars_and_alphanumeric
    assert_match /^\w{32}$/, ActiveMerchant::Utils.generate_unique_id
  end
end