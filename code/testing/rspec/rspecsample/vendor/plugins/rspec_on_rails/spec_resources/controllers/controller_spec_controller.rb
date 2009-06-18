#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class ControllerSpecController < ActionController::Base
  if ['edge','2.0.0'].include?(ENV['RSPEC_RAILS_VERSION'])
    set_view_path [File.join(File.dirname(__FILE__), "..", "views")]
  else
    set_view_path File.join(File.dirname(__FILE__), "..", "views")
  end
  
  def some_action
    render :template => "template/that/does/not/actually/exist"
  end
  
  def action_with_template
    session[:session_key] = "session value"
    flash[:flash_key] = "flash value"
    render :template => "controller_spec/action_with_template"
  end
  
  def action_with_partial
    render :partial => "controller_spec/partial"
  end
  
  def action_with_partial_with_object
    render :partial => "controller_spec/partial", :object => params[:thing]
  end
  
  def action_with_partial_with_locals
    render :partial => "controller_spec/partial", :locals => {:thing => params[:thing]}
  end
  
  def action_with_errors_in_template
    render :template => "controller_spec/action_with_errors_in_template"
  end

  def action_setting_the_assigns_hash
    assigns['direct_assigns_key'] = :direct_assigns_key_value
    @indirect_assigns_key = :indirect_assigns_key_value
  end
  
  def action_setting_flash_after_session_reset
    reset_session
    flash[:after_reset] = "available"
  end
  
  def action_setting_flash_before_session_reset
    flash[:before_reset] = 'available'
    reset_session
  end
  
  def action_with_render_update
    render :update do |page|
      page.replace :bottom, 'replace_me',
                            :partial => 'non_existent_partial'
    end
  end
end

