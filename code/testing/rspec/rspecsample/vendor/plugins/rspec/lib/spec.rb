#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'spec/version'
require 'spec/matchers'
require 'spec/expectations'
require 'spec/example'
require 'spec/extensions'
require 'spec/runner'

if Object.const_defined?(:Test); \
  require 'spec/interop/test'; \
end

module Spec
  class << self
    def run?
      @run || rspec_options.examples_run?
    end

    def run; \
      return true if run?; \
      result = rspec_options.run_examples; \
      @run = true; \
      result; \
    end
    attr_writer :run
    
    def exit?; \
      !Object.const_defined?(:Test) || Test::Unit.run?; \
    end
  end
end