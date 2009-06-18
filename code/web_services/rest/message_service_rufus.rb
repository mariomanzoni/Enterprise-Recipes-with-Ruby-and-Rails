#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'rubygems'
require 'rufus/verbs'
require 'uri'
require 'mandator'

include Rufus::Verbs

class MessageService
  def initialize(host, port)
    @base_url = "http://#{host}:#{port}/message-service"
  end
  
  def get_mandators
    response = get "#{@base_url}/mandators" 
    return [] if response.code.to_i == 404
    assert_response_code(response, 200)
    Mandator.from_xml(response.body)
  end
  
  def get_mandator(mandatorname)
    response = get mandator_path(mandatorname)
    return nil if response.code.to_i == 404
    assert_response_code(response, 200)
    Mandator.from_xml(response.body).first
  end
  
  def mandator_path(mandatorname)
    "#{@base_url}/mandators/#{URI.encode(mandatorname)}"
  end
  
  def assert_response_code(response, code)
    if response.code.to_i != code
      raise "Got unexpected response code: #{response.code}"
    end
  end
end



class MessageService
  XML_TYPE = 'application/xml'
  
  def create_mandator(mandator)
    response = post("#{@base_url}/mandators") do |req|
      req['content-type'] = XML_TYPE
      mandator.to_xml
    end
    assert_response_code(response, 201)
    response['location']
  end
  
  def update_mandator(mandatorname, mandator)
    options = { :no_redirections => true } 
    response = put(mandator_path(mandatorname), options) do |req|
      req['content-type'] = XML_TYPE
      mandator.to_xml
    end
    if !([200, 301].include?(response.code.to_i))
      raise "Could not update mandator: #{response.code}"
    end
  end
  
  def delete_mandator(mandatorname)
    response = delete(mandator_path(mandatorname)) do |req|
      req['content-type'] = XML_TYPE
    end
    assert_response_code(response, 200)
  end
end


if $0 == __FILE__
  service = MessageService.new('localhost', 3000)
  service.get_mandators.each { |m| service.delete_mandator m.name }
  
  service = MessageService.new('localhost', 3000)
  service.get_mandators.each { |m| puts m }
  puts service.get_mandator('foo')
  
  
  
  service = MessageService.new('localhost', 3000)
  
  # Create a new mandator named 'foo'.
  mandator = Mandator.new('foo', 42)
  service.create_mandator(mandator)
  puts service.get_mandator('foo')
  
  # Change the mandator's message limit to 1,000.
  mandator.message_limit = 1000
  service.update_mandator('foo', mandator)  
  puts service.get_mandator('foo')
  
  # Change the mandator's name to 'bar'.
  mandator.name = 'bar'
  service.update_mandator('foo', mandator)
  puts service.get_mandator('foo') # Does no longer exist!
  puts service.get_mandator('bar')
  
end
