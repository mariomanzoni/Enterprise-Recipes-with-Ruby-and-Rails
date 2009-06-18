#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CustomerController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.xml
    end
  end
end


class CustomerController < ApplicationController
  after_filter :convert, :only => [:show_flexible]
  
  def show_flexible
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.xml
    end
  end
end

