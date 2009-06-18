#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class RenderSpecController < ApplicationController
  set_view_path File.join(File.dirname(__FILE__), "..", "views")
  
  def some_action
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def action_which_renders_template_from_other_controller
    render :template => 'controller_spec/action_with_template'
  end
  
  def text_action
    render :text => "this is the text for this action"
  end
  
  def action_with_partial
    render :partial => "a_partial"
  end
  
  def action_that_renders_nothing
    render :nothing => true
  end
end
