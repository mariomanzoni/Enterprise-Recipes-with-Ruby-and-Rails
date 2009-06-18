#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'
require 'spec/mocks/errors'

describe ActionView::Base, "with RSpec extensions:", :type => :view do 
  
  describe "expect_render" do
    it "should not raise when render has been received" do
      template.expect_render(:partial => "name")
      template.render :partial => "name"
    end
  
    it "should raise when render has NOT been received" do
      template.expect_render(:partial => "name")
      lambda {
        template.verify_rendered
      }.should raise_error
    end
    
    it "should return something (like a normal mock)" do
      template.expect_render(:partial => "name").and_return("Little Johnny")
      result = template.render :partial => "name"
      result.should == "Little Johnny"
    end
  end
  
  describe "stub_render" do
    it "should not raise when stubbing and render has been received" do
      template.stub_render(:partial => "name")
      template.render :partial => "name"
    end
  
    it "should not raise when stubbing and render has NOT been received" do
      template.stub_render(:partial => "name")
    end
  
    it "should not raise when stubbing and render has been received with different options" do
      template.stub_render(:partial => "name")
      template.render :partial => "view_spec/spacer"
    end

    it "should not raise when stubbing and expecting and render has been received" do
      template.stub_render(:partial => "name")
      template.expect_render(:partial => "name")
      template.render(:partial => "name")
    end
  end

end
