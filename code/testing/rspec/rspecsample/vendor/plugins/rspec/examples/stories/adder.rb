#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class Adder
  def initialize
    @addends = []
  end
  
  def <<(val)
    @addends << val
  end
  
  def sum
    @addends.inject(0) { |sum_so_far, val| sum_so_far + val }
  end
end