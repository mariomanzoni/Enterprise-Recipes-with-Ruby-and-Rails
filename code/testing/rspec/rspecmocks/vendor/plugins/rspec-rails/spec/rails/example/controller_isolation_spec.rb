#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'
require 'controller_spec_controller'

describe "a controller spec running in isolation mode", :type => :controller do
  controller_name :controller_spec

  it "should not care if the template doesn't exist" do
    get 'some_action'
    response.should be_success
    response.should render_template("template/that/does/not/actually/exist")
  end

  it "should not care if the template has errors" do
    get 'action_with_errors_in_template'
    response.should be_success
    response.should render_template("action_with_errors_in_template")
  end
end

describe "a controller spec running in integration mode", :type => :controller do
  controller_name :controller_spec
  integrate_views
  
  before(:each) do
    controller.class.send(:define_method, :rescue_action) { |e| raise e }
  end

  it "should render a template" do
    get 'action_with_template'
    response.should be_success
    response.should have_tag('div', 'This is action_with_template.rhtml')
  end

  it "should choke if the template doesn't exist" do
    error = defined?(ActionController::MissingTemplate) ? ActionController::MissingTemplate : ActionView::MissingTemplate    
    lambda { get 'some_action' }.should raise_error(error)
    response.should_not be_success
  end

  it "should choke if the template has errors" do
    lambda { get 'action_with_errors_in_template' }.should raise_error(ActionView::TemplateError)
    response.should_not be_success
  end
  
  describe "nested" do
    it "should render a template" do
      get 'action_with_template'
      response.should be_success
      response.should have_tag('div', 'This is action_with_template.rhtml')
    end
    
    describe "with integrate_views turned off" do
      integrate_views false
      
      it "should not care if the template doesn't exist" do
        get 'some_action'
        response.should be_success
        response.should render_template("template/that/does/not/actually/exist")
      end
    end
  end
end
