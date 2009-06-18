#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../spec_helper.rb'

module Spec
  describe Runner, ".configure" do
    it "should yield global configuration" do
      Spec::Runner.configure do |config|
        config.should equal(Spec::Runner.configuration)
      end
    end
  end
end