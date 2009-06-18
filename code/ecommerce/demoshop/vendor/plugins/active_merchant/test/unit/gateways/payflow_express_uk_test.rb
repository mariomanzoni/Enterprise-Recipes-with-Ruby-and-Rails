#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../test_helper'

class PayflowExpressUkTest < Test::Unit::TestCase
  def setup
    @gateway = PayflowExpressUkGateway.new(
      :login => 'LOGIN',
      :password => 'PASSWORD'
    )
  end
  
  def test_supported_countries
    assert_equal ['GB'], PayflowExpressUkGateway.supported_countries
  end
end
