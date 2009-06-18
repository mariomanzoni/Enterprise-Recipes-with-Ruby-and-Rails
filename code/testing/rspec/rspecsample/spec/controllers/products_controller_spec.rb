#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do
  before(:each) do
    Product.create(:id => 1, :name => 'Ruby Book')
  end
  
  it 'should show single product' do
    get :show, :id => 1
    response.should be_success
    assigns[:product].should == Product.find(1)
  end
end
