#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')

describe <%= class_name %>Controller do

<% if actions.empty? -%>
  #Delete this example and add some real ones
<% else -%>
  #Delete these examples and add some real ones
<% end -%>
  it "should use <%= class_name %>Controller" do
    controller.should be_an_instance_of(<%= class_name %>Controller)
  end

<% unless actions.empty? -%>
<% for action in actions -%>

  describe "GET '<%= action %>'" do
    it "should be successful" do
      get '<%= action %>'
      response.should be_success
    end
  end
<% end -%>
<% end -%>
end
