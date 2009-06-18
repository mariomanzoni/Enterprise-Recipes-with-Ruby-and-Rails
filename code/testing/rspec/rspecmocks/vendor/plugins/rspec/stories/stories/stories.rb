#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.join(File.dirname(__FILE__), *%w[.. helper])
require File.join(File.dirname(__FILE__), *%w[steps multiline_steps])

with_steps_for :multiline_steps do
  run File.dirname(__FILE__) + "/multiline_steps.story"
end