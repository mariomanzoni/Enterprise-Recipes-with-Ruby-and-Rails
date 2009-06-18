#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'
unless [/mswin/, /java/].detect{|p| p =~ RUBY_PLATFORM}
  require 'spec/runner/heckle_runner'

  describe "Heckler" do
    it "should run examples on tests_pass?" do
      options = Spec::Runner::Options.new(StringIO.new, StringIO.new)
      options.should_receive(:run_examples).with().and_return(&options.method(:run_examples))
      heckler = Spec::Runner::Heckler.new('Array', 'push', options)
      heckler.tests_pass?
    end
  end
end
