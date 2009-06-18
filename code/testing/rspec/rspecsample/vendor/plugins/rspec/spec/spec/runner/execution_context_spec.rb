#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "ExecutionContext" do
  
  it "should provide duck_type()" do
    dt = duck_type(:length)
    dt.should be_an_instance_of(Spec::Mocks::DuckTypeArgConstraint)
    dt.matches?([]).should be_true
  end

  it "should violate when violated()" do
    lambda do
      violated
    end.should raise_error(Spec::Expectations::ExpectationNotMetError)
  end

  it "should provide mock()" do
    mock("thing").should be_an_instance_of(Spec::Mocks::Mock)
  end

  it "should provide stub()" do
    thing_stub = stub("thing").should be_an_instance_of(Spec::Mocks::Mock)
  end
  
  it "should add method stubs to stub()" do
    thing_stub = stub("thing", :a => "A", :b => "B")
    thing_stub.a.should == "A"
    thing_stub.b.should == "B"
  end

end
