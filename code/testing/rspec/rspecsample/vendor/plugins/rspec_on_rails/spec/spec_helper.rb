#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.expand_path("#{dir}/../rspec/lib"))
$LOAD_PATH.unshift(File.expand_path("#{dir}/../spec_resources/controllers"))
$LOAD_PATH.unshift(File.expand_path("#{dir}/../spec_resources/helpers"))
require File.expand_path("#{dir}/../../../../spec/spec_helper")
require File.expand_path("#{dir}/../spec_resources/controllers/render_spec_controller")
require File.expand_path("#{dir}/../spec_resources/controllers/rjs_spec_controller")
require File.expand_path("#{dir}/../spec_resources/controllers/redirect_spec_controller")
require File.expand_path("#{dir}/../spec_resources/controllers/action_view_base_spec_controller")
require File.expand_path("#{dir}/../spec_resources/helpers/explicit_helper")
require File.expand_path("#{dir}/../spec_resources/helpers/more_explicit_helper")
require File.expand_path("#{dir}/../spec_resources/helpers/view_spec_helper")
require File.expand_path("#{dir}/../spec_resources/helpers/plugin_application_helper")

ActionController::Routing.controller_paths << "#{dir}/../spec_resources/controllers"

module Spec
  module Rails
    module Example
      class ViewExampleGroupController
        set_view_path File.join(File.dirname(__FILE__), "..", "spec_resources", "views")
      end
    end
  end
end

def fail()
  raise_error(Spec::Expectations::ExpectationNotMetError)
end
  
def fail_with(message)
  raise_error(Spec::Expectations::ExpectationNotMetError,message)
end

class Proc
  def should_pass
    lambda { self.call }.should_not raise_error
  end
end

ActionController::Routing::Routes.draw do |map|
  map.resources :rspec_on_rails_specs
  map.connect 'custom_route', :controller => 'custom_route_spec', :action => 'custom_route'
  map.connect ":controller/:action/:id"
end

