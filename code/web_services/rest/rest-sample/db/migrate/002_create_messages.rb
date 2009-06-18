#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreateMessages < ActiveRecord::Migration
  def self.up
    
    create_table :messages do |t|
      t.column :mandator_id, :int
      t.column :sender,      :string
      t.column :receiver,    :string
      t.column :content,     :string
      t.column :status,      :string, :default => 'in-transmission'
      t.timestamps
    end
    
  end
end

class CreateMessages
  def self.down
    drop_table :messages
  end
end
