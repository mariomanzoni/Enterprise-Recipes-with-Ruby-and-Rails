#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def method_in_plugin_application_helper
    "<div>This is text from a method in the ApplicationHelper</div>"
  end
end