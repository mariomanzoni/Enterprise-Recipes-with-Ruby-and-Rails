#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
Product = Struct.new(:name)

class Stock
  attr_reader :products
  
  def initialize
    @products = []
  end
  
  def empty?
    @products.empty?
  end

  def add_product(product)
    raise ArgumentError if product.nil? or product.name.nil?
    @products << product
  end
  
  def products_by_name(name)
    @products.select { |p| p.name == name }
  end
  
  def count
    @products.size
  end
end
