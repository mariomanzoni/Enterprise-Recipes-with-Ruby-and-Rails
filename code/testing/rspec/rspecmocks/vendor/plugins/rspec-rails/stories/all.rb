#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.join(File.dirname(__FILE__), *%w[helper])
require File.join(File.dirname(__FILE__), *%w[steps people])

# Run transactions_should_rollback in Ruby
require File.join(File.dirname(__FILE__), *%w[transactions_should_rollback])

# Run transactions_should_rollback in Plain Text
with_steps_for :people do
  run File.join(File.dirname(__FILE__), *%w[transactions_should_rollback]), :type => RailsStory
end