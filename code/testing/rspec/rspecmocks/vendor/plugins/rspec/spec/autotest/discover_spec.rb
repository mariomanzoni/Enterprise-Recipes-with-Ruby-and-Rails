#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + "/../autotest_helper"

module DiscoveryHelper
  def load_discovery
    require File.dirname(__FILE__) + "/../../lib/autotest/discover"
  end
end


class Autotest
  describe Rspec, "discovery" do
    include DiscoveryHelper
    
    it "should add the rspec autotest plugin" do
      Autotest.should_receive(:add_discovery).and_yield
      load_discovery
    end
  end  
end
