#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

describe "A shared view example_group", :shared => true do
  it "should have some tag with some text" do
    response.should have_tag('div', 'This is text from a method in the ViewSpecHelper')
  end
end

describe "A view example_group", :type => :view do
  it_should_behave_like "A shared view example_group"
  
  before(:each) do
    render "view_spec/implicit_helper"
  end
end
  
