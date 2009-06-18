#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreateFoo < ActiveRecord::Migration
  def self.up
    create_table :foo do |t|
      t.string :bar, :limit => 255
    end
  end

  def self.down
    drop_table :foo
  end
end
