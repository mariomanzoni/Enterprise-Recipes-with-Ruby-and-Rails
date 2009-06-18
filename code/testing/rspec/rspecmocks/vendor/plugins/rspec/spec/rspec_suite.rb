#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
if __FILE__ == $0
  dir = File.dirname(__FILE__)
  Dir["#{dir}/**/*_spec.rb"].reverse.each do |file|
#    puts "require '#{file}'"
    require file
  end
end
