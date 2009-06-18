#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

module Spec
  module Example
    class ExampleGroupSubclass < ExampleGroup
      class << self
        attr_accessor :examples_ran
      end

      @@klass_variable_set = true
      CONSTANT = :foobar

      before do
        @instance_variable = :hello
      end

      it "should run" do
        self.class.examples_ran = true
      end

      it "should have access to instance variables" do
        @instance_variable.should == :hello
      end

      it "should have access to class variables" do
        @@klass_variable_set.should == true
      end

      it "should have access to constants" do
        CONSTANT.should == :foobar
      end

      it "should have access to methods defined in the Example Group" do
        a_method.should == 22
      end

      def a_method
        22
      end
    end

    describe ExampleGroupSubclass do
      it "should run" do
        ExampleGroupSubclass.examples_ran.should be_true
      end
    end
  end
end