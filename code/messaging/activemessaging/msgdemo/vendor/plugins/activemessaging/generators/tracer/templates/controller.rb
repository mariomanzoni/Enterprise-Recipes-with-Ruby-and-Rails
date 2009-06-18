#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class <%= class_name %>Controller < ApplicationController
  include ActiveMessaging::MessageSender
  
  publishes_to :trace

  def index
  end

  def clear
    publish :trace, "<trace-control>clear</trace-control>"
    redirect_to :action=>'index'
  end

end
