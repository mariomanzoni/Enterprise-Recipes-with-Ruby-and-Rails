#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class CreateWeatherInformation < ActiveRecord::Migration
  def self.up
    
    create_table :weather_information do |t|
      t.string  :location, :cond_day, :cond_night
      t.date    :date
      t.float   :temp_max, :temp_min
      t.integer :rain_probability
      t.timestamps
    end
    
  end

  def self.down
    drop_table :weather_information
  end
end
