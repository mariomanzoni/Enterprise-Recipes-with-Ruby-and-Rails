#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'stringio'

dir = File.dirname(__FILE__)
lib_path = File.expand_path("#{dir}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)
$_spec_spec = true # Prevents Kernel.exit in various places

require 'spec'
require 'spec/mocks'
require 'spec/story'
spec_classes_path = File.expand_path("#{dir}/../spec/spec/spec_classes")
require spec_classes_path unless $LOAD_PATH.include?(spec_classes_path)
require File.dirname(__FILE__) + '/../lib/spec/expectations/differs/default'

module Spec  
  module Example
    class NonStandardError < Exception; end
  end

  module Matchers
    def fail
      raise_error(Spec::Expectations::ExpectationNotMetError)
    end

    def fail_with(message)
      raise_error(Spec::Expectations::ExpectationNotMetError, message)
    end

    def exception_from(&block)
      exception = nil
      begin
        yield
      rescue StandardError => e
        exception = e
      end
      exception
    end
  end
end

share_as :SandboxedOptions do
  attr_reader :options

  before(:each) do
    @original_rspec_options = ::Spec::Runner.options
    ::Spec::Runner.use(@options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new))
  end

  after(:each) do
    ::Spec::Runner.use(@original_rspec_options)
  end

  def run_with(options)
    ::Spec::Runner::CommandLine.run(options)
  end
end unless Object.const_defined?(:SandboxedOptions)
