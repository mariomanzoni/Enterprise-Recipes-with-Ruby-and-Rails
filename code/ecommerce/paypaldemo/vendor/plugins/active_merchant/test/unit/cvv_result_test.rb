#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class CVVResultTest < Test::Unit::TestCase
  def test_nil_data
    result = CVVResult.new(nil)
    assert_nil result.code
    assert_nil result.message
  end
  
  def test_blank_data
    result = CVVResult.new('')
    assert_nil result.code
    assert_nil result.message
  end
  
  def test_successful_match
    result = CVVResult.new('M')
    assert_equal 'M', result.code
    assert_equal CVVResult.messages['M'], result.message
  end
  
  def test_failed_match
    result = CVVResult.new('N')
    assert_equal 'N', result.code
    assert_equal CVVResult.messages['N'], result.message
  end
  
  def test_to_hash
    result = CVVResult.new('M').to_hash
    assert_equal 'M', result['code']
    assert_equal CVVResult.messages['M'], result['message']
  end
end