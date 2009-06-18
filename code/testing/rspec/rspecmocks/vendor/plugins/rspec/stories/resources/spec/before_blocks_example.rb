#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
$:.unshift File.join(File.dirname(__FILE__), *%w[.. .. .. lib])
require 'spec'

Spec::Runner.configure do |config|
  config.before(:suite) do
    $before_suite = "before suite"
  end
  config.before(:each) do
    @before_each = "before each"
  end
  config.before(:all) do
    @before_all = "before all"
  end
end

describe "stuff in before blocks" do
  describe "with :suite" do
    it "should be available in the example" do
      $before_suite.should == "before suite"
    end
  end
  describe "with :all" do
    it "should be available in the example" do
      @before_all.should == "before all"
    end
  end
  describe "with :each" do
    it "should be available in the example" do
      @before_each.should == "before each"
    end
  end
end