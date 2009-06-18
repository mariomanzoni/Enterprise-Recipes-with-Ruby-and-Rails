#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'xml/libxml'

class CreditCardTransaction
  XACTION_DIR = File.join('data', 'cc_xactions')
  
  attr_reader :xaction_id, :cc_ref, :type, :amount, :text
  
  def initialize(xaction_id, cc_ref, type, amount, text)
    @xaction_id, @cc_ref, @type = xaction_id, cc_ref, type
    @amount, @text = amount, text
  end
  
  def self.find_all(cc_ref)
    xactions = []
    input_file = "#{XACTION_DIR}/xactions.xml"
    doc = XML::Document.file(input_file) 
    doc.find('//cc-xactions/cc-xaction').each do |node| 
      if node['cc-ref'] == cc_ref
        xactions << CreditCardTransaction.new(
          node['id'], 
          node['cc-ref'],
          node['type'],
          node['amount'],
          node.find_first('text') 
        )
      end
    end
    xactions
  end
end
