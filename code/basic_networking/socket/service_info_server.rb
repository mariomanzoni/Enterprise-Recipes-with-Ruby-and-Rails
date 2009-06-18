#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'gserver'
require 'activerecord'

class ServiceInfo < ActiveRecord::Base; end

class ServiceInfoServer < GServer
  def initialize(port = 12345, logger = $stdout)
    super(port, GServer::DEFAULT_HOST, Float::MAX, logger, true)
  end
end


require 'logger'

class ServiceInfoServer
  def log(message, level = Logger::INFO)
    @stdlog.add(level) { message } if @stdlog
  end
  
  def debug(message) log(message, Logger::DEBUG); end
  def info(message) log(message); end
  def warn(message) log(message, Logger::WARN); end
  def fatal(message) log(message, Logger::FATAL); end
end

  

class ServiceInfoServer
  def serve(client)
    begin
      command = client.gets.chomp
      info "Got command: #{command}"
      if command =~ /info\s+(.+)/
        service_name = $1
        if si = ServiceInfo.find_by_name(service_name)
          client.puts 'OK'
          si.attributes.each { |k,v| client.puts "#{k}: #{v}" }
        else
          client.puts "ERROR: service #{service_name} is unknown."
        end
      else
        client.puts 'ERROR: command #{command} is unknown.'
      end
    rescue => ex
      fatal "An error occured: #{ex.message}"
      client.puts 'ERROR'
    end
  end
end



class ServiceInfoServer
  def connecting(client)
    hostname = client.peeraddr[2] || client.peeraddr[3]
    info "Got a request from #{hostname}."
  end
  
  def stopping
    info 'Shutting down server.'
    @stdlog.close if @stdlog
  end
end


if $0 == __FILE__
  ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql', :database => 'services',
    :username => 'admin', :password => 't0p$ecret'
  )
  
  logger = Logger.new('server.log')
  logger.formatter = proc { |severity, datetime, progname, msg|
      "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} #{severity} - #{msg}\n"
  }
  server = ServiceInfoServer.new(12345, logger)
  
  server.start(-1)
  server.join
end
