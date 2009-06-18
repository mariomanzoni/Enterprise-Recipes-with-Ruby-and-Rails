#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class ResponseTest < Test::Unit::TestCase
  def test_response_success
    assert Response.new(true, 'message', :param => 'value').success?
    assert !Response.new(false, 'message', :param => 'value').success?
  end
  
  def test_get_params
    response = Response.new(true, 'message', :param => 'value')
    
    assert_equal ['param'], response.params.keys
  end
  
  def test_avs_result
    response = Response.new(true, 'message', {}, :avs_result => { :code => 'A', :street_match => 'Y', :zip_match => 'N' })
    avs_result = response.avs_result
    assert_equal 'A', avs_result['code']
    assert_equal AVSResult.messages['A'], avs_result['message']
  end
  
  def test_cvv_result
    response = Response.new(true, 'message', {}, :cvv_result => 'M')
    cvv_result = response.cvv_result
    assert_equal 'M', cvv_result['code']
    assert_equal CVVResult.messages['M'], cvv_result['message']
  end
end
