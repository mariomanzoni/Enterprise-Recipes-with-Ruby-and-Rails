#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreateManufacturers < ActiveRecord::Migration
  def self.up
    
    create_table :manufacturers do |t|
      t.string :name
      t.timestamps
    end
    
    # Load sample data:
    Manufacturer.create(:name => 'Nokia')
    Manufacturer.create(:name => 'Apple')
    
  end

  def self.down
    drop_table :manufacturers
  end
end
