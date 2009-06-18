#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'logger'
require 'rubygems'

require 'daemons'
Daemons.daemonize :backtrace => true


working_dir = ARGV[0] || '/tmp/orders'
interval = (ARGV[1] || 10).to_i
logger = Logger.new File.join(working_dir, 'order_import.log')
logger.info 'Started order import...'

loop do 
  orders = Dir["#{working_dir}/order*.xml"]
  orders.each do |filename| 
    logger.info "Processing #{filename}."
    
    # Do something with order file...
    
    File.delete(filename)
  end 
  sleep interval
end 
