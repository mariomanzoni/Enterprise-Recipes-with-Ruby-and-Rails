#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
God.load File.join(File.dirname(__FILE__), 'email_conf.rb')

control_script = '/tmp/order_import_control.rb'
God.watch do |w| 
  w.name = 'order_import' 
  w.interval = 60.seconds
  w.start = "#{control_script} start"
  w.stop = "#{control_script} stop"
  w.restart = "#{control_script} restart"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = '/tmp/order_import.rb.pid'
  w.group = 'server' 
  
  w.behavior(:clean_pid_file) 

  w.start_if do |start| 
    start.condition(:process_running) do |c|
      c.interval = 20.seconds
      c.running = false
      c.notify = 'admin'
    end
  end

  w.restart_if do |restart| 
    restart.condition(:memory_usage) do |c|
      c.above = 100.megabytes
      c.times = [3, 5]
      c.notify = 'admin'
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 60.percent
      c.times = 5
      c.notify = %w(admin boss)
    end
  end
end
