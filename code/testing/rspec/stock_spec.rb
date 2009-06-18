#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.join(File.dirname(__FILE__), 'stock')


shared_examples_for 'non-empty stock' do
  it { @stock.should_not be_empty }
  it { @stock.should have_at_least(1).products }
end



describe Stock do
  before(:each) do
    @stock = Stock.new
  end
  
  it 'should not accept empty products' do
    lambda { @stock.add_product(nil) }.should raise_error(ArgumentError) 
  end
  
  describe '(empty)' do
    it { @stock.should be_empty }
  
    it 'should not contain products having a certain name' do
      @stock.should have(0).products_by_name('foo')
    end
    
    it 'should add a product' do
      lambda {
        @stock.add_product Product.new('foo')
      }.should change(@stock, :count).by(1) 
    end
  end
  
  describe 'with a single foo product' do
    before(:each) do
      @stock.add_product Product.new('foo')
    end
    
    it_should_behave_like 'non-empty stock' 
    
    it 'should find a product named "foo"' do
      @stock.should have(1).products
      @stock.should have(1).products_by_name('foo')
      @stock.products.first.name.should be_eql('foo') 
    end
  end
end

