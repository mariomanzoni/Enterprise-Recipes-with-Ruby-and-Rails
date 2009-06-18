#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Test
  module Unit
    class TestCase
      # Edge rails (r8664) introduces class-wide setup & teardown callbacks for Test::Unit::TestCase.
      # Make sure these still get run when running TestCases under rspec:
      prepend_before(:each) do
        run_callbacks :setup if respond_to?(:run_callbacks)
      end
      append_after(:each) do
        run_callbacks :teardown if respond_to?(:run_callbacks)
      end
    end
  end
end