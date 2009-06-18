#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreateCellPhones < ActiveRecord::Migration
  def self.up
    
    create_table :cell_phones do |t|
      t.belongs_to :manufacturer
      t.string     :model
      t.integer    :weight
      t.boolean    :gps
      t.timestamps
    end
    
    # Load sample data:
    [
      ['Nokia', 'N95',       120, true],
      ['Apple', 'iPhone',    135, false],
      ['Apple', 'iPhone 3G', 133, true],
    ].each do |p|
      CellPhone.create(
        :manufacturer_id => Manufacturer.find_by_name(p[0]).id,
        :model => p[1], :weight => p[2], :gps => p[3]
      )
    end
    
  end

  def self.down
    drop_table :cell_phones
  end
end
