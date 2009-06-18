#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreateMandators < ActiveRecord::Migration
  def self.up
    
    create_table :mandators do |t|
      t.column :name,          :string
      t.column :message_limit, :int
      t.timestamps
    end
    
  end
end

class CreateMandators
  def self.down
    drop_table :mandators
  end
end
