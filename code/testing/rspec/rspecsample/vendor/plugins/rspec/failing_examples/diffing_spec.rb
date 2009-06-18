#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
describe "Running specs with --diff" do
  it "should print diff of different strings" do
    uk = <<-EOF
RSpec is a
behaviour driven development
framework for Ruby
EOF
    usa = <<-EOF
RSpec is a
behavior driven development
framework for Ruby
EOF
    usa.should == uk
  end

  class Animal
    def initialize(name,species)
      @name,@species = name,species
    end

    def inspect
      <<-EOA
<Animal
name=#{@name},
species=#{@species}
>
      EOA
    end
  end

  it "should print diff of different objects' pretty representation" do
    expected = Animal.new "bob", "giraffe"
    actual   = Animal.new "bob", "tortoise"
    expected.should eql(actual)
  end
end
