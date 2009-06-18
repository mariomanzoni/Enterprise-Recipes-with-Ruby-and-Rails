#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class AddCompletedToPurchase < ActiveRecord::Migration
  def self.up
    add_column :purchases, :completed, :boolean
  end

  def self.down
    remove_column :purchases, :completed
  end
end
