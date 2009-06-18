#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# First, we create a test file containing random data.
cc_amount = (ARGV[0] || 1000).to_i
input_file = 'big_file.xml'

types = %w(purchase credit)
amounts = %w(1.23 42.12 19.99 29.99 39.99 12.00 0.99)
texts = [
  'Monthly bill.',
  'A new book.',
  'Insurance.'
]

File.open(input_file, 'w') do |f|
  f.puts "<cc-xactions date='#{Time.now.strftime('%Y%m%d')}'>"
  1.upto(cc_amount) do |id|
    type = types[rand(types.size)]
    amount = amounts[rand(amounts.size)]
    text = texts[rand(texts.size)]
    f.puts <<-"INVOICE"
  <cc-xaction id='#{100_000 + id}' cc-ref='#{rand(10000000)}' type='#{type}' amount='#{amount}'>
    <text>#{text}</text>
  </cc-xaction>
    INVOICE
  end
  f.puts '</cc-xactions>'
end

# Then we parse it using REXML and libxml2.
class CreditCardTransaction < Struct.new(:xaction_id, :cc_ref, :type, :amount, :text); end


require 'rexml/document'
def rexml_parse(xml_string)
  xactions = []
  doc = REXML::Document.new(xml_string) 
  doc.elements.each('//cc-xactions/cc-xaction') do |node|
    xactions << CreditCardTransaction.new(
      node.attributes['id'],
      node.attributes['cc-ref'],
      node.attributes['type'],
      node.attributes['amount'],
      node.elements['text'].text
    )
  end 
  xactions
end


require 'rubygems'

require 'xml/libxml'
def libxml_parse(xml_string)
  xactions = []
  parser = XML::Parser.new 
  parser.string = xml_string
  doc = parser.parse
  doc.find('//cc-xactions/cc-xaction').each do |node|
    xactions << CreditCardTransaction.new(
      node['id'],
      node['cc-ref'],
      node['type'],
      node['amount'],
      node.find('text').to_a.first.content
    )
  end 
  xactions
end



require 'hpricot'
def hpricot_parse(xml_string)
  xactions = []
  doc = Hpricot.XML(xml_string) 
  (doc/'//cc-xactions/cc-xaction').each do |node|
    xactions << CreditCardTransaction.new(
      node['id'],
      node['cc-ref'],
      node['type'],
      node['amount'],
      (node/'text').inner_html
    )
  end 
  xactions
end



require 'benchmark'
xml_string = IO::read(input_file)
label_width = 8
Benchmark.bm(label_width) do |x|
  x.report('rexml:  ') { rexml_parse(xml_string) }
  x.report('libxml: ') { libxml_parse(xml_string) }
  x.report('hpricot:') { hpricot_parse(xml_string) }
end


puts "We've scanned #{cc_amount} elements."
puts "File size is #{File.size(input_file)} bytes."

File.delete(input_file)
