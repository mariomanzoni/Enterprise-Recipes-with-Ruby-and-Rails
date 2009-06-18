#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/story_helper'

require 'spec/story'

describe Kernel, "#Story" do
  before(:each) do
    Kernel.stub!(:at_exit)
  end

  it "should delegate to ::Spec::Story::Runner.story_runner" do
    ::Spec::Story::Runner.story_runner.should_receive(:Story)
    story = Story("title","narrative"){}
  end
end
