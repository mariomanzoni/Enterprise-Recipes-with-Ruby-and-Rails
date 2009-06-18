#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'ed81347a76c8424515d8c86a42a0b896'
end


class ApplicationController
  def if_found(obj)
    if obj
      yield
    else
      render :text => 'Not found.', :status => '404 Not Found'
      false
    end
  end
end

  

class ApplicationController
  def must_specify_mandator
    if params[:mandatorname]
      @mandator = Mandator.find_by_name(params[:mandatorname])
      if_found(@mandator) { params[:mandator_id] = @mandator.id }
      return false unless @mandator
    end
    true
  end
end

