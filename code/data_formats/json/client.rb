#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

customers = [
  {
    :id => 42,
    :name => {
      :forename => 'Maik', :surname => 'Schmidt'
    },
    :address => {
      :street  => 'Musterstraße 42',
      :city    => 'Musterstadt',
      :country => 'Germany'
    },
    'bank-account' => {
      'bank-code' => '11122233', :bac => '987654321'
    }
  }
]



require 'rubygems'
require 'json'
require 'net/http'

payload = customers.to_json 
puts JSON.pretty_generate(customers) 
http = Net::HTTP.new('localhost', 8080)
response = http.post('/e-score', payload)
scores = JSON.parse(response.body) 
scores.each do |score|
  puts "Customer #{score['id']}: #{score['escore']}"
end

