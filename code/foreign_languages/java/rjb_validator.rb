#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'rjb'
classpath = '.:lib/jdom.jar:lib/xercesImpl.jar'
Rjb::load(classpath)
SchemaValidator = Rjb::import('SchemaValidator') 
xml_file, xml_schema_file = ARGV[0 .. 1]
doc = SchemaValidator.isValid(xml_file, xml_schema_file) 
if doc.nil?  
  puts "#{xml_file} is invalid."
else
  puts "#{xml_file} is valid."
  puts "Receiver: " + doc.getRootElement.getChild('receiver').getText
end

