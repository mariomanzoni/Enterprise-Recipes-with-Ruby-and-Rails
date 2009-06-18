#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'test/unit'
require 'stock'

class StockTest < Test::Unit::TestCase
  def setup
    @stock = Stock.new
  end
  
  def test_new_stock_is_empty
    assert @stock.empty?
  end
  
  def test_empty_stock_should_not_contain_a_product_having_a_name
    assert_equal 0, @stock.products_by_name('foo').size
  end
end
