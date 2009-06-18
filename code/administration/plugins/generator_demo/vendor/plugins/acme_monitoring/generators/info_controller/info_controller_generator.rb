#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class InfoControllerGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    @application_name = args.shift || 'UnknownApplication'
    @custom_methods = args || []
  end
  
  def manifest
    record do |m|
      m.template( 
        'info_controller.rb',
        'app/controllers/info_controller.rb',
        :collision => :skip,
        :assigns => {
          :application_name => @application_name,
          :custom_methods   => @custom_methods
        }
      )
      
      m.directory 'app/views/info' 
      @custom_methods.each do |method|
        m.template(
          'view.html.erb',
          "app/views/info/#{method}.html.erb",
          :collision => :skip,
          :assigns => { :method_name => method }
        )
      end
    end
  end
end
