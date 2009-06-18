#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'date'

class CreateCustomers < ActiveRecord::Migration
  def self.up
    
    create_table :customers do |t|
      t.string :forename
      t.string :surname
      t.date   :date_of_birth
      t.timestamps
    end
    
    Customer.create(
      :forename      => 'John',
      :surname       => 'Doe',
      :date_of_birth => Date.new(1968, 7, 22)
    )
    
  end

  def self.down
    drop_table :customers
  end
end
