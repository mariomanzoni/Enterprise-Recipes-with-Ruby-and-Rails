#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'

require 'ruport'
phones = Table(%w(manufacturer model weight gps)) 
phones << {
  'manufacturer' => 'Nokia', 'model' => 'N95',
  'weight' => '120', 'gps' => true
}
phones << {
  'manufacturer' => 'Apple', 'model' => 'iPhone',
  'weight' => '135', 'gps' => false
}
puts phones
puts 'Column names: ' + phones.column_names.join(', ')



phones = phones.sub_table(%w(manufacturer model weight))
phones.rename_columns(
  'manufacturer' => 'Manufacturer',
  'model'        => 'Model',
  'weight'       => 'Weight (gram)'
)
puts phones
puts 'Column names: ' + phones.column_names.join(', ')



phones.swap_column('Model', 'Manufacturer')
phones << {
  'Manufacturer' => 'Apple', 'Model' => 'iPhone 3G',
  'Weight (gram)' => '133', 'gps' => true
}
puts phones



puts phones.to_csv



puts phones.sort_rows_by(%w(Manufacturer Model)).to_html



grouping = Grouping(phones, :by => 'Manufacturer')
puts grouping


File.open('phones.pdf', 'w') { |f| f.puts phones.to_pdf }
__END__

require 'active_record'
require 'ruport/acts_as_reportable'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :username => 'maik',
  :password => 't0p$ecret',
  :database => 'ruport_test'
)

class CellPhone < ActiveRecord::Base
  acts_as_reportable
end

phones = CellPhone.report_table(:all, :only => %w(manufacturer model))
puts phones
