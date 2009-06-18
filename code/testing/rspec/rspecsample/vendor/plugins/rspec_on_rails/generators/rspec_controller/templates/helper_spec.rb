#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper'

describe <%= class_name %>Helper do
  
  #Delete this example and add some real ones or delete this file
  it "should include the <%= class_name %>Helper" do
    included_modules = self.metaclass.send :included_modules
    included_modules.should include(<%= class_name %>Helper)
  end
  
end
