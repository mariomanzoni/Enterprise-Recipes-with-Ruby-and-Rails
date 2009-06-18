#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class CountryTest < Test::Unit::TestCase
  include ActiveMerchant

  def test_country_from_hash
    country = Country.new(:name => 'Canada', :alpha2 => 'CA', :alpha3 => 'CAN', :numeric => '124')
    assert_equal 'CA', country.code(:alpha2).to_s
    assert_equal 'CAN', country.code(:alpha3).to_s
    assert_equal '124', country.code(:numeric).to_s
    assert_equal 'Canada', country.to_s
  end

  def test_country_for_alpha2_code
    country = Country.find('CA')
    assert_equal 'CA', country.code(:alpha2).to_s
    assert_equal 'CAN', country.code(:alpha3).to_s
    assert_equal '124', country.code(:numeric).to_s
    assert_equal 'Canada', country.to_s
  end
  
  def test_country_for_alpha3_code
    country = Country.find('CAN')
    assert_equal 'Canada', country.to_s
  end

  def test_country_for_numeric_code
    country = Country.find('124')
    assert_equal 'Canada', country.to_s
  end

  def test_find_country_by_name
    country = Country.find('Canada')
    assert_equal 'Canada', country.to_s
  end

  def test_find_unknown_country_name
    assert_raise(InvalidCountryCodeError) do
      Country.find('Asskickistan')
    end
  end
  
  def test_find_australia
    country = Country.find('AU')
    assert_equal 'AU', country.code(:alpha2).to_s
    
    country = Country.find('Australia')
    assert_equal 'AU', country.code(:alpha2).to_s
  end
  
  def test_find_united_kingdom
    country = Country.find('GB')
    assert_equal 'GB', country.code(:alpha2).to_s
    
    country = Country.find('United Kingdom')
    assert_equal 'GB', country.code(:alpha2).to_s
  end
  
  def test_raise_on_nil_name
    assert_raise(InvalidCountryCodeError) do
      Country.find(nil)
    end
  end
end
