#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'sinatra'
require 'activerecord'

configure do 
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => './catalog.db',
    :timeout  => 5000
  )

  class CreateProducts < ActiveRecord::Migration
    def self.up
      create_table :products, :force => true do |t|
        t.string  :name
        t.decimal :price, :precision => 10, :scale => 2
      end
    end
  end
  CreateProducts.up
  
  class Product < ActiveRecord::Base
    validates_uniqueness_of :name
  end
  Product.create(:name => 'Beer', :price => 6.99)
end



get '/products' do
  header 'Content-Type' => 'text/xml; charset=utf-8' 
  products = Product.find(:all)
  builder do |xml|
    xml.instruct!
    xml.products do
      products.each do |product|
        xml.product :name => product.name, :price => product.price
      end
    end
  end
end



helpers do
  def product_to_xml(xml, product)
    xml.product :name => product.name, :price => product.price
  end
end

get '/products/:id' do
  header 'Content-Type' => 'text/xml; charset=utf-8'
  unless product = Product.find_by_id(params[:id]) 
    response.status = 404
  else
    builder do |xml|
      xml.instruct!
      product_to_xml(xml, product) 
    end
  end
end



require 'rexml/document'

post '/products' do
  xml = request.env['rack.input'].read 
  doc = REXML::Document.new(xml)
  product = Product.create(
    :name => doc.elements['/product/@name'].value,
    :price => doc.elements['/product/@price'].value.to_f
  )
  header 'Location' => "/products/#{product.id}" 
  response.status = 201
end


put '/products/:id' do
end


delete '/products/:id' do
  if Product.exists?(params[:id])
    Product.delete(params[:id])
  else
    response.status = 404
  end
end



get '/screen.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :screen
end

get '/catalog' do  
  @products = Product.find(:all)
  haml :catalog
end

