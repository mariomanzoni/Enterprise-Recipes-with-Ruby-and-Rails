#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class SpecSuite
  def run
    system("ruby rspec/spec/rspec_suite.rb") || raise("Rspec Suite FAILED")
    system("ruby rspec_on_rails/spec/rails_suite.rb") || raise("Rails Suite FAILED")
    system("ruby cached_example_rails_app/spec/rails_app_suite.rb") || raise("Rails App Suite FAILED")
  end
end

if $0 == __FILE__
  SpecSuite.new.run
end
