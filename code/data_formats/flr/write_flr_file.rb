#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'flrfile'

FLR.open('/tmp/results.flr', 'w', [3, 2, 40]) do |flr|
  flr << [1, 0, 'Maik Schmidt']
  flr << [2, 0, 'John Doe']
  flr << [3, 9, 'Jane Rodriguez']
end



result = FLR.generate([3, 2, 40]) do |flr|
  flr << [1, 0, 'Maik Schmidt']
  flr << [2, 0, 'John Doe']
  flr << [3, 9, 'Jane Rodriguez']
end
puts result

