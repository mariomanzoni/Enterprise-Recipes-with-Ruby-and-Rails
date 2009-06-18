#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class SessionsController < ApplicationController
  def create
    if using_open_id? 
      open_id_authentication
    else
      password_authentication(params[:name], params[:password])
    end
  end

  protected

  def password_authentication(name, password)
    if @user = User.authenticate(name, password)
      successful_login
    else
      failed_login "User name and/or password is wrong."
    end
  end

  def open_id_authentication
    authenticate_with_open_id do |result, identity_url| 
      unless result.successful?
        failed_login(result.message) and return
      end
      if @user = User.find_or_create_by_identity_url(identity_url)
        successful_login
      else
        failed_login "Identity URL #{identity_url} is unknown."
      end
    end
  end
  
  private

  def successful_login
    session[:user_id] = @user.id
    redirect_to :controller => 'Main'
  end

  def failed_login(message)
    flash[:error] = message
    redirect_to(new_session_url)
  end
end
