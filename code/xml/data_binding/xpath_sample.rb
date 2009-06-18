#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rexml/document'


doc = REXML::Document.new(File.new('invoices/94429999.xml'))
doc.elements['//items/item[1]/name'].text # -> 'Beer'
doc.elements['//net-amount/@amount']      # -> '7.73'

puts doc.elements['//items/item[1]/name'].text # -> 'Beer'
puts doc.elements['//net-amount/@amount']      # -> '7.73'
