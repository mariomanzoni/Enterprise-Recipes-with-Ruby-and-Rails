#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'rubygems'
require 'spec/mocks'
mock = Spec::Mocks::Mock.new 'test'
include Spec::Mocks::ArgumentConstraintMatchers


mock.should_receive(:method).with(no_args())
mock.should_receive(:method).with(any_args())
mock.should_receive(:method).with(/foo/)
mock.should_receive(:method).with('foo', anything(), true)
mock.should_receive(:method).with(duck_type(:walk, :talk))
mock.should_receive(:method).twice
mock.should_receive(:method).exactly(3).times
mock.should_receive(:method).at_least(:once)
mock.should_receive(:method).at_most(:twice)
mock.should_receive(:method).any_number_of_times

