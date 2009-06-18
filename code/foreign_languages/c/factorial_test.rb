#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'


class FactorialTest
  def factorial(n)
    result = 1
    n.downto(2) { |x| result *= x }
    result
  end
end



require 'inline'
class FactorialTest
  inline(:C) do |builder|
    builder.c <<-CSOURCE
    long factorial_c(const int n) {
      long result = 1, i = n;
      while (i >= 2)
        result *= i--;
      return result;
    }
    CSOURCE
  end
end



require 'benchmark'
label_width = 6
test = FactorialTest.new
Benchmark.bm(label_width) do |x|
  x.report('ruby: ') { 1.upto(10_000_000) { test.factorial(12) } }
  x.report('C: ')    { 1.upto(10_000_000) { test.factorial_c(12) } }
end



test = FactorialTest.new
puts "factorial(15)   = #{test.factorial(15)}"
puts "factorial_c(15) = #{test.factorial_c(15)}"

