#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'dispatcher' unless defined?(::Dispatcher)
::Dispatcher.class_eval do

  def self.prepare_application_for_dispatch
    if (self.private_methods.include? "prepare_application")
      prepare_application
    else
      new(STDOUT).prepare_application
    end
  end  

  def self.reset_application_after_dispatch
    if (self.private_methods.include? "reset_after_dispatch")
      reset_after_dispatch
    else
      new(STDOUT).cleanup_application
    end
  end
  
end
