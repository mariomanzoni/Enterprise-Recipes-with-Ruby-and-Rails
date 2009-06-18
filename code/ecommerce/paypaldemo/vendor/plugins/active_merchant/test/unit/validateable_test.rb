#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class Dood
  include ActiveMerchant::Validateable

  attr_accessor :name, :email, :country

  def validate
    errors.add "name", "cannot be empty" if name.blank?
    errors.add "email", "cannot be empty" if email.blank?
    errors.add_to_base "The country cannot be blank" if country.blank?
  end

end

class ValidateableTest < Test::Unit::TestCase
  include ActiveMerchant
  
  def setup
    @dood = Dood.new
  end

  def test_validation  
    assert ! @dood.valid?
    assert ! @dood.errors.empty?
  end

  def test_assigns 
    @dood = Dood.new(:name => "tobi", :email => "tobi@neech.de", :country => 'DE')

    assert_equal "tobi", @dood.name 
    assert_equal "tobi@neech.de", @dood.email
    assert @dood.valid?
  end

  def test_multiple_calls
    @dood.name = "tobi"        
    assert !@dood.valid?    
    
    @dood.email = "tobi@neech.de"    
    assert !@dood.valid?
    
    @dood.country = 'DE'
    assert @dood.valid?
  end

  def test_messages
    @dood.valid?
    assert_equal "cannot be empty", @dood.errors.on('name')
    assert_equal "cannot be empty", @dood.errors.on('email')
    assert_equal nil, @dood.errors.on('doesnt_exist')

  end

  def test_full_messages
    @dood.valid?
    assert_equal ["Email cannot be empty", "Name cannot be empty", "The country cannot be blank"], @dood.errors.full_messages.sort
  end

end
