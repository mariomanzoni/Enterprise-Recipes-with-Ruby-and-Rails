#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'fastercsv'
require 'activerecord'

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


require 'ar-extensions'
logger = Logger.new('import.log')
logger.level = Logger::INFO
ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :database => 'sample',
  :username => 'maik',
  :password => 't0p$ecret'
)
ActiveRecord::Base.logger = logger

CreateLocations.up

def load(filename, chunk_size = 3_000, validate = true)
  options = {
    :headers => true,
    :header_converters => :symbol,
    :col_sep => ';'
  }

  locations = []
  FasterCSV.foreach(filename, options) do |row|
    locations << Location.new(row.to_hash)
    if locations.size % chunk_size == 0
      Location.import locations, :validate => validate 
      locations = []
    end
  end
  Location.import locations, :validate => validate if locations.size > 0
end


load(ARGV[0], 1_000, false)
puts Location.count
