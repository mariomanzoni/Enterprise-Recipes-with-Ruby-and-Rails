#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
amount = (ARGV[0] || 200000).to_i
File.open('huge_file.csv', 'w') do |f|
  f.puts "label;street;postal_code;city;country"
  i = 1
  while i < amount do
    f.puts "Location #{i};Musterstraße 42;12345;Musterstadt;DE"
    f.puts "Location #{i + 1};1234 Sample Street;99887;Sample City;GB"
    i += 2
  end
end
