#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rexml/document'

class Mandator
  attr_accessor :name, :message_limit
  
  def initialize(name, message_limit)
    @name, @message_limit = name, message_limit
  end
  
  def to_s
    "#{@name}: #{@message_limit}"
  end
  
  def to_xml
    doc = REXML::Document.new
    doc.add_element('mandator',
      'name' => @name, 'message_limit' => @message_limit 
    )
    xml_string = ''
    doc.write(xml_string)
    xml_string
  end
  
  def Mandator.from_xml(xml_string)
    mandators = []
    doc = REXML::Document.new(xml_string)
    doc.each_element('//mandator') do |element|
      mandators << Mandator.new(
        element.attributes['name'],
        element.attributes['message_limit']
      )
    end
    mandators
  end
end
