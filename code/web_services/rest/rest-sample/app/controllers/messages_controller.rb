#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :must_specify_mandator
  
  # GET /message-service/{mandatorname}/messages
  def index
    messages = @mandator.messages
    messages = nil if messages.empty?
    if_found(messages) { render :xml => messages.to_xml }
  end

  # GET /message-service/{mandatorname}/messages/{id}
  def show
    message = Message.find(params[:id])
    if_found(message) { render :xml => message.to_xml }
  end
  
  # POST /message-service/{mandatorname}/messages
  def create
    limit = @mandator.message_limit
    if limit != -1 and @mandator.messages.size >= limit
      render :nothing => true, :status => '400 Bad Request'
    else
      sms = params[:message]
      status = send_message(sms)
      message = Message.create(
        :mandator => @mandator,
        :receiver => sms[:receiver][:phone_number],
        :sender   => sms[:sender][:phone_number],
        :content  => sms[:content],
        :status   => status
      )
      headers[:location] = message_path(@mandator.name, message) 
      render :nothing => true, :status => '201 Created'
    end
  end

  def update
    render :nothing => true, :status => '405 Method Not Allowed'
  end
      
  def destroy
    render :nothing => true, :status => '405 Method Not Allowed'
  end
      
  private
  
  def send_message(sms)
    # Add your code to send short messages here.
    'in-transmission'    
  end
end
