#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module ActionController
  module Rescue
    def use_rails_error_handling!
      @use_rails_error_handling = true
    end

    def use_rails_error_handling?
      @use_rails_error_handling ||= false
    end

    protected
    def rescue_action_with_fast_errors(exception)
      if use_rails_error_handling?
        rescue_action_without_fast_errors exception
      else
        raise exception
      end
    end
    alias_method_chain :rescue_action, :fast_errors
  end
end
