#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/test_unit_spec_helper'

describe "ExampleGroup with test/unit/interop" do
  include TestUnitSpecHelper
  
  before(:each) do
    @dir = File.dirname(__FILE__) + "/resources"
  end
  
  describe "with passing examples" do
    it "should output 0 failures" do
      output = ruby("#{@dir}/spec_that_passes.rb")
      output.should include("1 example, 0 failures")
    end

    it "should return an exit code of 0" do
      ruby("#{@dir}/spec_that_passes.rb")
      $?.should == 0
    end
  end

  describe "with failing examples" do
    it "should output 1 failure" do
      output = ruby("#{@dir}/spec_that_fails.rb")
      output.should include("1 example, 1 failure")
    end

    it "should return an exit code of 256" do
      ruby("#{@dir}/spec_that_fails.rb")
      $?.should == 256
    end
  end

  describe "with example that raises an error" do
    it "should output 1 failure" do
      output = ruby("#{@dir}/spec_with_errors.rb")
      output.should include("1 example, 1 failure")
    end

    it "should return an exit code of 256" do
      ruby("#{@dir}/spec_with_errors.rb")
      $?.should == 256
    end
  end
end