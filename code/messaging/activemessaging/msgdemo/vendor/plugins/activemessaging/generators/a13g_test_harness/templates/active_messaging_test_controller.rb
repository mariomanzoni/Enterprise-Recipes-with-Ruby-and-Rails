#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class ActiveMessagingTestController < ApplicationController

  include ActiveMessaging::MessageSender

  def index
    @destinations = ActiveMessaging::Gateway.named_destinations.values

    if request.post?
      @message = params[:message]

      if params[:destination].nil? || params[:destination].empty?
        flash[:notice] = "Please specify a destination."
        return
      else
        @destination = params[:destination].intern
      end

      if @message.nil? || @message.empty?
        flash[:notice] = "Please specify a message."
        return
      end

      puts "#{@destination} : #{@message}"
      publish @destination, @message
      flash[:notice] = "'#{@message}' sent to #{@destination}"
    end
  end

end
