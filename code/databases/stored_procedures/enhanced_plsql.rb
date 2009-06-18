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
ActiveRecord::Base.establish_connection(
  :adapter  => 'oracle_enhanced',
  :username => 'maik',
  :password => 't0p$ecret'
)
plsql.connection = ActiveRecord::Base.connection.raw_connection

class Customer < ActiveRecord::Base
  set_table_name :customer
 
  set_create_method do 
    plsql.add_customer(forename, surname, date_of_birth)
  end
end



maik = Customer.create(
  :forename      => 'Maik',
  :surname       => 'Schmidt',
  :date_of_birth => Time.mktime(1972, 9, 30)
)

jane = Customer.new
jane.forename = 'Jane'
jane.surname = 'Rodriguez'
jane.date_of_birth = Time.mktime(1973, 2, 21)
jane.save

