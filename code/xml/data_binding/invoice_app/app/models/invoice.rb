#!/usr/bin/env ruby
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---


Money = Struct.new(:currency, :amount)
Address = Struct.new(:street, :postal_code, :city)
Customer = Struct.new(:customer_no, :name, :address)
Vat = Struct.new(:rate, :amount)
Item = Struct.new(
  :product_id, :name, :unit_price, :quantity,
  :net_amount, :gross_amount, :vat
)
class Invoice
  attr_accessor :invoice_no, :invoice_date, :due_date, :customer
  attr_accessor :net_amount, :gross_amount, :vat, :items
end



class Invoice
  private
  
  def self.get_money(node)
    Money.new(node.attributes['currency'], node.attributes['amount'])
  end
  
  def self.get_customer(invoice_node)
    customer_node = invoice_node.elements['customer']
    Customer.new(
      customer_node.attributes['customer-no'],
      customer_node.elements['name'].text,
      get_address(customer_node)
    )
  end
  
  def self.get_address(customer_node)
    address_node = customer_node.elements['address']
    Address.new(
      address_node.elements['street'].text,
      address_node.elements['postal-code'].text,
      address_node.elements['city'].text
    )
  end
  
  def self.get_vat(invoice_node)
    Vat.new(
      invoice_node.elements['vat'].attributes['rate'],
      get_money(invoice_node.elements['vat'])
    )
  end
  
  def self.get_items(invoice_node)
    items = []
    invoice_node.elements.each('items/item') do |item|  
      items << Item.new(
        item.attributes['product-id'],
        item.elements['name'].text,
        get_money(item.elements['unit-price']),
        item.elements['quantity'].text.to_i,
        get_money(item.elements['net-amount']),
        get_money(item.elements['gross-amount']),
        item.elements['vat'].attributes['rate']
      )
    end
    items
  end
end



require 'rexml/document'
class Invoice
  INVOICES_DIR = File.join('data', 'invoices')
  
  def self.find(customer_no)
    filename = File.join(INVOICES_DIR, "#{customer_no}.xml")
    invoice_doc = REXML::Document.new(File.new(filename))   
    invoice_node = invoice_doc.root.elements[1] 
    invoice = Invoice.new
    invoice.invoice_no = invoice_node.attributes['invoice-no'] 
    invoice.invoice_date = invoice_node.elements['invoice-date'].text 
    invoice.due_date = invoice_node.elements['due-date'].text 
    invoice.customer = get_customer(invoice_node)
    invoice.net_amount = get_money(invoice_node.elements['net-amount'])
    invoice.gross_amount = get_money(
      invoice_node.elements['gross-amount']
    )
    invoice.vat = get_vat(invoice_node)
    invoice.items = get_items(invoice_node)
    invoice
  end
end


if $0 == __FILE__
  # TODO: Move test code to Rails unit test.
  require 'test/unit'
  class InvoiceTest < Test::Unit::TestCase
    def test_regular_case
      invoice = Invoice.find('94429999')
      assert_not_nil invoice
      assert_equal 2, invoice.items.size
      assert_equal '47110815', invoice.invoice_no
      assert_equal '2008-09-15', invoice.invoice_date
      assert_equal '2008-10-01', invoice.due_date
      assert_equal '7.73', invoice.net_amount.amount
      assert_equal 'USD', invoice.net_amount.currency
      assert_equal '8.97', invoice.gross_amount.amount
      assert_equal 'USD', invoice.gross_amount.currency
      assert_equal '1.24', invoice.vat.amount.amount
      assert_equal 'USD', invoice.vat.amount.currency
      assert_equal '16.0', invoice.vat.rate
      customer = invoice.customer
      assert_equal 'Maik Schmidt', customer.name
      assert_equal 'Musterstraße 42', customer.address.street
      assert_equal 'Musterstadt', customer.address.city
      assert_equal '12345', customer.address.postal_code
      item1 = invoice.items[0]
      assert_equal '42-007-x', item1.product_id
      assert_equal 'Beer', item1.name
      assert_equal '0.99', item1.unit_price.amount
      assert_equal 'USD', item1.unit_price.currency
      assert_equal 6, item1.quantity
      assert_equal '5.94', item1.net_amount.amount
      assert_equal 'USD', item1.net_amount.currency
      assert_equal '6.89', item1.gross_amount.amount
      assert_equal 'USD', item1.gross_amount.currency
      assert_equal '16.0', item1.vat
      item2 = invoice.items[1]
      assert_equal '16-666-x', item2.product_id
      assert_equal 'Nuts & Gum', item2.name
      assert_equal '1.79', item2.unit_price.amount
      assert_equal 'USD', item2.unit_price.currency
      assert_equal 1, item2.quantity
      assert_equal '1.79', item2.net_amount.amount
      assert_equal 'USD', item2.net_amount.currency
      assert_equal '2.08', item2.gross_amount.amount
      assert_equal 'USD', item2.gross_amount.currency
      assert_equal '16.0', item2.vat
    end
  end
end
