#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

class SecureCopyMessageSender
  attr_accessor :host, :username, :password, :target_dir

  def initialize
    @host = 'localhost'
    @username = 'anonymous'
    @target_dir = '.'
  end
end


require 'net/scp'

class SecureCopyMessageSender
  def send(message_id, content)
    filename = File.join(@target_dir, "#{message_id}.xml")
    Net::SCP.start(@host, @username, :password => @password) do |scp|
      scp.upload! StringIO.new(content), filename 
    end
  end
end


if $0 == __FILE__
  
  sender = SecureCopyMessageSender.new
  sender.host = 'localhost'
  sender.username = 'maik'
  sender.password = 't0p$ecret'
  sender.target_dir = '/data/in'
  message = "<?xml version='1.0'?>\n<order id='0815'/>\n"
  sender.send('order-0815', message)
  
end
