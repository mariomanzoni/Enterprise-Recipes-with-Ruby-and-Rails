#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

describe "An AssignsHashProxy" do
  before(:each) do
    @object = Object.new
    @assigns = Hash.new
    @object.stub!(:assigns).and_return(@assigns)
    @proxy = Spec::Rails::Example::AssignsHashProxy.new(@object)
  end

  it "has [] accessor" do
    @proxy['foo'] = 'bar'
    @assigns['foo'].should == 'bar'
    @proxy['foo'].should == 'bar'
  end

  it "works for symbol key" do
    @assigns[:foo] = 2
    @proxy[:foo].should == 2
  end

  it "checks for string key before symbol key" do
    @assigns['foo'] = false
    @assigns[:foo] = 2
    @proxy[:foo].should == false
  end

  it "each method iterates through each element like a Hash" do
    values = {
      'foo' => 1,
      'bar' => 2,
      'baz' => 3
    }
    @proxy['foo'] = values['foo']
    @proxy['bar'] = values['bar']
    @proxy['baz'] = values['baz']

    @proxy.each do |key, value|
      key.should == key
      value.should == values[key]
    end
  end

  it "delete method deletes the element of passed in key" do
    @proxy['foo'] = 'bar'
    @proxy.delete('foo').should == 'bar'
    @proxy['foo'].should be_nil
  end

  it "has_key? detects the presence of a key" do
    @proxy['foo'] = 'bar'
    @proxy.has_key?('foo').should == true
    @proxy.has_key?('bar').should == false
  end
end
