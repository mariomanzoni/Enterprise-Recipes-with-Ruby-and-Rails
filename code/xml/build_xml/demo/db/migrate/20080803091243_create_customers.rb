#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :customer_no, :forename, :surname
      t.string :street, :city, :postal_code
      t.timestamps
    end
    Customer.create(
      :customer_no => '94429999',
      :forename => 'Maik',
      :surname => 'Schmidt',
      :street => 'Musterstraße 42',
      :city => 'Musterstadt',
      'postal_code' => '12345'
    )
  end

  def self.down
    drop_table :customers
  end
end
