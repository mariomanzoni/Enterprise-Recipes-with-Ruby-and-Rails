#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.expand_path("#{File.dirname(__FILE__)}/../helper")

# This creates steps for :addition
steps_for(:addition) do
  Given("an addend of $addend") do |addend|
    @adder ||= Adder.new
    @adder << addend.to_i
  end
end

# This appends to them
steps_for(:addition) do
  When("the addends are added")  { @sum = @adder.sum }
end

steps_for(:more_addition) do
  Then("the sum should be $sum") { |sum| @sum.should == sum.to_i }
end
