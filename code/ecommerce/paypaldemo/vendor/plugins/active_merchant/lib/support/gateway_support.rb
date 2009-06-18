#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'active_support'
require 'lib/active_merchant'


class GatewaySupport #:nodoc:
  ACTIONS = [:purchase, :authorize, :capture, :void, :credit, :recurring]
  
  include ActiveMerchant::Billing

  attr_reader :gateways
  
  def initialize
    @gateways = Gateway.implementations.sort_by(&:name)
    @gateways.delete(ActiveMerchant::Billing::BogusGateway)
  end
  
  def each_gateway
    @gateways.each{|g| yield g }
  end
  
  def features
    width = 15
    
    print "Name".center(width + 20)
    ACTIONS.each{|f| print "#{f.to_s.capitalize.center(width)}" }
    puts
    
    each_gateway do |g|
      print "#{g.display_name.ljust(width + 20)}"
      ACTIONS.each do |f|
        print "#{(g.instance_methods.include?(f.to_s) ? "Y" : "N").center(width)}"
      end
      puts
    end
  end
  
  def to_rdoc
    each_gateway do |g|
      puts "* {#{g.display_name}}[#{g.homepage_url}] - #{g.supported_countries.join(', ')}"
    end
  end
  
  def to_textile
    each_gateway do |g|
      puts %/ * "#{g.display_name}":#{g.homepage_url} [#{g.supported_countries.join(', ')}]/
    end
  end
  
  def to_s
    each_gateway do |g|
      puts "#{g.display_name} - #{g.homepage_url} [#{g.supported_countries.join(', ')}]"
    end
  end
end


    