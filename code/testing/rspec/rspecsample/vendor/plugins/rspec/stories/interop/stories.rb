#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.join(File.dirname(__FILE__), *%w[.. helper])

with_steps_for :running_rspec do
  Dir["#{File.dirname(__FILE__)}/*"].each do |file|
    run file if File.file?(file) && !(file =~ /\.rb$/)
  end
end