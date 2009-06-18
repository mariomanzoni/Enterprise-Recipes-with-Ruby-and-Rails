#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class RjsSpecController < ApplicationController
  set_view_path File.join(File.dirname(__FILE__), "..", "views")
  
  def replace_html
  end
  
  def insert_html
  end
  
  def replace
  end
  
  def hide_div
  end
  
  def hide_page_element
  end

  def replace_html_with_partial
  end

  def render_replace_html
    render :update do |page|
      page.replace_html 'mydiv', 'replacement text'
      page.replace_html 'myotherdiv', 'other replacement text'
    end
  end
  
  def render_replace_html_with_partial
    render :update do |page|
      page.replace_html 'mydiv', :partial => 'rjs_spec/replacement_partial'
    end
  end
  
  def render_insert_html
    render :update do |page|
      page.insert_html 'mydiv', 'replacement text'
    end
  end
  
  def render_replace
    render :update do |page|
      page.replace 'mydiv', 'replacement text'
    end
  end
  
  def render_hide_div
    render :update do |page|
      page.hide 'mydiv'
    end
  end
  
  def render_hide_page_element
    render :update do |page|
      page['mydiv'].hide
    end
  end
end
