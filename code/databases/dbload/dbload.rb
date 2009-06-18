#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'activerecord'
require 'faster_csv'


class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations, :force => true do |t|
      t.string :label, :street, :postal_code, :city, :country
    end
  end

  def self.down
    drop_table :locations
  end
end



class Location < ActiveRecord::Base
  validates_presence_of :label, :street, :postal_code, :city, :country
end



class Location
  def self.load(filename)
    options = {
      :headers => true,
      :header_converters => :symbol,
      :col_sep => ';'
    }
    
    begin
      Location.transaction do 
        FasterCSV.foreach(filename, options) do |row|
          Location.create!(row.to_hash)  
        end
      end
    rescue => ex
      $stderr.puts ex 
    end
  end
end



ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :database => 'sample',
  :username => 'maik',
  :password => 't0p$ecret'
)

CreateLocations.up

Location.load(ARGV[0])

