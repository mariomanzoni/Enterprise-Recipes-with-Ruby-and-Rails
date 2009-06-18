#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'logger'
require 'win32/daemon'
include Win32
 
class OrderImportService < Daemon
  def initialize(opts = {}) 
    super()
    @opts = opts 
  end 

  def service_init 
    @interval = @opts[:interval] || 10
    @working_dir = @opts[:working_dir] || 'c:/orders'
    @logger = Logger.new(@opts[:logfile] || 'c:/order_import.log')
    @logger.info 'Starting order import...'
  end
    
  def service_main 
    @logger.info 'Order import has been started.'
    while running? 
      orders = Dir["#{@working_dir}/order*.xml"]
      orders.each do |filename| 
        @logger.info "Processing #{filename}."

        # Do something with order file...

        File.delete(filename)
      end 
      sleep(@interval) 
    end
    @logger.info 'Order import has been stopped.'
  end
end

if __FILE__ == $0
  order_import_service = OrderImportService.new
  order_import_service.mainloop 
end

