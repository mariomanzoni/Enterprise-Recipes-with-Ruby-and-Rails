#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
$:.push File.join(File.dirname(__FILE__), *%w[.. .. .. lib])
require "rubygems"
require 'spec'

Spec::Runner.configure do |config|
  config.mock_with :flexmock
end

# This is to ensure that requiring spec/mocks/framework doesn't interfere w/ flexmock
require 'spec/mocks/framework'

describe "something" do
  it "should receive some message" do
    target = Object.new
    flexmock(target).should_receive(:foo).once
    lambda {flexmock_verify}.should raise_error
  end
end