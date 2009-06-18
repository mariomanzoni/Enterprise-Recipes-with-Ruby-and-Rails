#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class <%= class_name %> < ActiveRecord::Migration
  def self.up
    drop_table :open_id_authentication_settings
    drop_table :open_id_authentication_nonces

    create_table :open_id_authentication_nonces, :force => true do |t|
      t.integer :timestamp, :null => false
      t.string :server_url, :null => true
      t.string :salt, :null => false
    end
  end

  def self.down
    drop_table :open_id_authentication_nonces

    create_table :open_id_authentication_nonces, :force => true do |t|
      t.integer :created
      t.string :nonce
    end

    create_table :open_id_authentication_settings, :force => true do |t|
      t.string :setting
      t.binary :value
    end
  end
end
