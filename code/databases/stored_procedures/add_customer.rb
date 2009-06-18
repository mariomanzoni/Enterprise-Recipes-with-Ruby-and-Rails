#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'date'
require 'rubygems'

require 'activerecord'

class Customer < ActiveRecord::Base
  set_table_name :customer 
  
  def self.create(params)
    cursor = self.connection.raw_connection.parse <<-PLSQL 
    DECLARE
      new_id PLS_INTEGER;
    BEGIN
      :new_id := add_customer(:forename, :surname, :date_of_birth);
    END;
    PLSQL
    cursor.bind_param('forename', params[:forename], String, 60)
    cursor.bind_param('surname', params[:surname], String, 60)
    cursor.bind_param('date_of_birth', params[:date_of_birth])
    cursor.bind_param('new_id', nil, Fixnum)
    cursor.exec
    new_id = cursor['new_id'] 
    cursor.close
    customer = Customer.new
    customer.id = new_id
    customer.forename = params[:forename]
    customer.surname = params[:surname]
    customer.date_of_birth = params[:date_of_birth]
    customer
  end
end



ActiveRecord::Base.establish_connection(
  :adapter  => 'oracle',
  :username => 'maik',
  :password => 't0p$ecret'
)

me = Customer.create(
  :forename      => 'Maik',
  :surname       => 'Schmidt',
  :date_of_birth => Time.mktime(1972, 9, 30)
)
puts "My ID is #{me.id}."

me_again = Customer.find(me.id)
puts "My name is #{me_again.forename}."



require 'ruby_plsql'
plsql.connection = ActiveRecord::Base.connection.raw_connection
new_id = plsql.add_customer('Jane', 'Rodriguez', Date.today)

puts "Jane's ID is #{me.id}."
