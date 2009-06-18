#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
$:.push File.join(File.dirname(__FILE__), *%w[.. .. .. lib])
require 'test/unit'
require 'spec'
require 'spec/interop/test'

class MySpec < Test::Unit::TestCase
  def should_pass_with_should
    1.should == 1
  end

  def should_fail_with_should
    1.should == 2
  end

  def should_pass_with_assert
    assert true
  end
  
  def should_fail_with_assert
    assert false
  end

  def test
    raise "This is not a real test"
  end

  def test_ify
    raise "This is a real test"
  end
end