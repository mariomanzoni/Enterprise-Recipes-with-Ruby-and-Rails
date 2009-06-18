#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'win32/service'
include Win32

def install_service(name, display_name, executable) 
  Service.create(
    name,
    nil,
    :display_name => display_name,
    :binary_path_name => 'ruby ' + File.expand_path(executable)
  )
  puts "Service #{name} has been installed." 
end 



install_service( 
  'order_import', 
  'Order Import',
  'order_import.rb'
)

