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

  def serve(client)
    begin
      command = client.gets.chomp 
      log "Got command: #{command}"
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
      log "An error occurred: #{ex.message}" 
      client.puts 'ERROR'
    end
  end
end



ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql', :database => 'services',
  :username => 'admin', :password => 't0p$ecret'
)
server = ServiceInfoServer.new(12345)
server.start
server.join

