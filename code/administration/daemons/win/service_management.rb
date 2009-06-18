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

def wait_for_state(state)
  print "Waiting for state '#{state}'"
  i = 0
  while Service.status('order_import').current_state != state
    i += 1
    print '.' if i % 1000 == 0
  end
  puts
end

puts "Display name: #{Service.get_display_name('order_import')}" 

Service.configure(
  'order_import',
  nil,
  :display_name => 'Order Import 2008'
)
Service.start('order_import')
wait_for_state('running')
puts 'Service has been started.'

Service.pause('order_import')
wait_for_state('paused')
puts 'Service has been paused.'

Service.resume('order_import')
puts 'Service has been resumed.'
wait_for_state('running')

Service.stop('order_import')
wait_for_state('stopped')
puts 'Service has been stopped.'

Service.delete('order_import')
puts 'Service has been uninstalled.'

