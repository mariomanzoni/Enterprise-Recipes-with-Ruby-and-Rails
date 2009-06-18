#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

describe "assert_equal", :shared => true do
  it "like assert_equal" do
    assert_equal 1, 1
    lambda {
      assert_equal 1, 2
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
end

describe "A model spec should be able to access 'test/unit' assertions", :type => :model do
  it_should_behave_like "assert_equal"
end

describe "A view spec should be able to access 'test/unit' assertions", :type => :view do
  it_should_behave_like "assert_equal"
end

describe "A helper spec should be able to access 'test/unit' assertions", :type => :helper do
  it_should_behave_like "assert_equal"
end

describe "A controller spec with integrated views should be able to access 'test/unit' assertions", :type => :controller do
  controller_name :controller_spec
  integrate_views
  it_should_behave_like "assert_equal"
end

describe "A controller spec should be able to access 'test/unit' assertions", :type => :controller do
  controller_name :controller_spec
  it_should_behave_like "assert_equal"
end
