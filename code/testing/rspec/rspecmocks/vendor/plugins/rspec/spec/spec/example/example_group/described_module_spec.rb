#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + "/../../../spec_helper"

module Spec
  module Example
    module  AModule;  end
    class   AClass;   end

    describe "With", AModule do
      it "should have the described_type as 'AModule'" do
        self.class.described_module.should == AModule
      end
    end
    
    describe "With", AClass do
      it "should have the described_module as nil" do
        self.class.described_module.should be_nil
      end
    end
  end
end
