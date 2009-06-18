#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.join(File.dirname(__FILE__), 'stock')


describe Stock, '(newly created)' do
  before(:each) do
    @stock = Stock.new
  end
  
  it { @stock.should be_empty } 
  
  it 'should not contain products having a certain name' do
    @stock.should have(0).products_by_name('foo')      
  end
end

