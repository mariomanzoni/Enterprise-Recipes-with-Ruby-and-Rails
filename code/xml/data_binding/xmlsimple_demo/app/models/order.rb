#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

class Order
  ORDER_DIR = File.join('data', 'orders')
  
  def self.find(order_id)
    XmlSimple.xml_in(
      File.join(ORDER_DIR, "#{order_id}.xml"),
      'force_array' => ['item'],
      'group_tags'  => { 'items' => 'item' }
    )
  end
end



class Order
  def self.to_xml(order)
    builder = XmlSimple.new(
      'root_name'  => 'order', 
      'group_tags' => { 
        'customer-no' => 'content',
        'items'       => 'item',
        'name'        => 'content',
        'quantity'    => 'content'
      }
    )
    builder.xml_out(order)
  end
end


if $0 == __FILE__
  require 'rubygems'
  require 'xmlsimple'
  require 'pp'
  order = Order.find('47110815')
  pp order
  puts Order.to_xml(order)
end
