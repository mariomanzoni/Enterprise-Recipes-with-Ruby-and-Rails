#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

class MockableClass
  def self.find id
    return :original_return
  end
end

describe "A partial mock" do

  it "should work at the class level" do
    MockableClass.should_receive(:find).with(1).and_return {:stub_return}
    MockableClass.find(1).should equal(:stub_return)
  end

  it "should revert to the original after each spec" do
    MockableClass.find(1).should equal(:original_return)
  end

  it "can be mocked w/ ordering" do
    MockableClass.should_receive(:msg_1).ordered
    MockableClass.should_receive(:msg_2).ordered
    MockableClass.should_receive(:msg_3).ordered
    MockableClass.msg_1
    MockableClass.msg_2
    MockableClass.msg_3
  end

end
