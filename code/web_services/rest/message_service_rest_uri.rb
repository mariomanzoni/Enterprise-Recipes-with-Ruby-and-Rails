#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'uri'
require 'rest-open-uri'
require 'mandator'

class MessageService
  XML_TYPE = 'application/xml'
  
  def initialize(host, port)
    @base_url = "http://#{host}:#{port}/message-service"
  end
  
  
  def get_mandators
    response = nil
    begin
      response = open "#{@base_url}/mandators"
    rescue OpenURI::HTTPError => ex 
      return [] if ex.message =~ /^404/
    end
    assert_response_code(response, 200)
    Mandator.from_xml(response.read)
  end
  
  def create_mandator(mandator)
    response = open(
      "#{@base_url}/mandators",
      :method => :post, 
      :body => mandator.to_xml,
      'content-type' => XML_TYPE
    )
    assert_response_code(response, 201)
    response.meta['location'] 
  end
  
  def assert_response_code(response, code)
    if response.status[0].to_i != code 
      raise "Got unexpected response code: #{response.code}"
    end
  end
  
end

class MessageService
  def get_mandator(mandatorname)
    response = nil
    begin
      response = open mandator_path(mandatorname)
    rescue OpenURI::HTTPError => ex
      return nil if ex.message =~ /^404/
    end
    assert_response_code(response, 200)
    Mandator.from_xml(response.read).first
  end
  
  def update_mandator(mandatorname, mandator)
    response = open(
      mandator_path(mandatorname),
      :method => :put,
      :body => mandator.to_xml,
      'content-type' => XML_TYPE
    )
    if !([200, 301].include?(response.status[0].to_i))
      raise "Could not update mandator: #{response.code}"
    end
  end
  
  def delete_mandator(mandatorname)
    response = open(
      mandator_path(mandatorname),
      :method => :delete,
      'content-type' => XML_TYPE
    )
    assert_response_code(response, 200)
  end

  def mandator_path(mandatorname)
    "#{@base_url}/mandators/#{URI.encode(mandatorname)}"
  end
end

if $0 == __FILE__
  service = MessageService.new('localhost', 3000)
  service.get_mandators.each { |m| service.delete_mandator m.name }
  puts service.get_mandator('foo')
  
  service = MessageService.new('localhost', 3000)
  mandator = Mandator.new('foo', 42)
  service.create_mandator(mandator)
  puts service.get_mandator('foo')
  mandator.message_limit = 1000
  service.update_mandator('foo', mandator)
  puts service.get_mandator('foo')
  mandator.name = 'bar'
  service.update_mandator('foo', mandator)
  
  puts service.get_mandator('foo') # -> nil
  puts service.get_mandator('bar')
end
