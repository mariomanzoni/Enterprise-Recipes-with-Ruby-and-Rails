#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class AuthenticationController < ApplicationController
  before_filter :authenticate, :except => [ :unprotected ] 

  def unprotected
    render :text => "Access granted to anyone.\n" 
  end

  def forbidden
    render :text => "Access granted exclusively to you.\n"
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password| 
      user_name == 'maik' && password == 't0p$ecret'
    end
  end
end
