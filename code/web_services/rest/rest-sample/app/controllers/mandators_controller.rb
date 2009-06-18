#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class MandatorsController < ApplicationController
  skip_before_filter :verify_authenticity_token 

  # POST /message-service/mandators
  def create
    mandator = Mandator.find_or_create_by_name(
      :name => params[:mandator][:name], 
      :message_limit => params[:mandator][:message_limit]
    )
    headers[:location] = mandator_path(mandator) 
    render :nothing => true, :status => '201 Created'
  end
end



class MandatorsController
  # GET /message-service/mandators
  def index
    mandators = Mandator.find(:all)
    if_found(mandators) { render :xml => mandators.to_xml }
  end
  
  # GET /message-service/mandators/{mandatorname}
  def show
    mandator = Mandator.find_by_name(params[:id])
    if_found(mandator) { render :xml => mandator.to_xml }
  end
  
  # PUT /message-service/mandators/{mandatorname}
  def update
    mandator = Mandator.find_by_name(params[:id])
    if_found mandator do
      current_name = mandator.name
      attributes = {
        :name => params[:mandator][:name],
        :message_limit => params[:mandator][:message_limit]
      }
      if mandator.update_attributes(attributes)
        if mandator.name == current_name
          render :nothing => true, :status => '200 OK'
        else
          headers[:location] = mandator_path(mandator)
          render :nothing => true, 
                 :status => '301 Moved Permanently'
        end
      else
        render :xml => mandator.errors.to_xml,
               :status => '400 Bad Request'
      end
    end
  end

  # DELETE /message-service/mandators/{mandatorname}
  def destroy
    mandator = Mandator.find_by_name(params[:id])
    if_found mandator do
      mandator.messages.each { |m| m.destroy }
      mandator.destroy
      render :nothing => true, :status => '200 OK'
    end
  end
end

