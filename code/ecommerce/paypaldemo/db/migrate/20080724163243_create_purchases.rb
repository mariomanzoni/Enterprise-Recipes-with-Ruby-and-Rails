#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreatePurchases < ActiveRecord::Migration
  def self.up
    
    create_table :purchases do |t|
      t.belongs_to :order
      t.decimal    :amount, :precision => 10, :scale => 2
      t.timestamps
      
    end
  end

  def self.down
    drop_table :purchases
  end
end
