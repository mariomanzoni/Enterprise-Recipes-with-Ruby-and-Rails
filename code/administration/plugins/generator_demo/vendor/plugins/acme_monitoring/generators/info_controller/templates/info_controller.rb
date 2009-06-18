#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class InfoController < ApplicationController
  def status
    application_name = '<%= application_name %>'
    status = "Everything's OK with #{application_name}." 
    render :text => status
  end
  <% for method in custom_methods %> 
  <% next if method == 'status' %>
  def <%= method %>
    # Your code here.
  end
  <% end %>
end
