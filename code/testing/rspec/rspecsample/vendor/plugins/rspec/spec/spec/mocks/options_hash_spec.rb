#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

module Spec
  module Mocks
    describe "calling :should_receive with an options hash" do
      it_should_behave_like "sandboxed rspec_options"
      attr_reader :reporter, :example_group
      before do
        @reporter = ::Spec::Runner::Reporter.new(options)
        @example_group = Class.new(::Spec::Example::ExampleGroup) do
          plugin_mock_framework
          describe("Some Examples")
        end
        reporter.add_example_group example_group
      end

      it "should report the file and line submitted with :expected_from" do
        example_definition = example_group.it "spec" do
          mock = Spec::Mocks::Mock.new("a mock")
          mock.should_receive(:message, :expected_from => "/path/to/blah.ext:37")
          mock.rspec_verify
        end
        example = example_group.new(example_definition)
        
        reporter.should_receive(:example_finished) do |spec, error|
          error.backtrace.detect {|line| line =~ /\/path\/to\/blah.ext:37/}.should_not be_nil
        end
        example.execute(options, {})
      end

      it "should use the message supplied with :message" do
        example_definition = @example_group.it "spec" do
          mock = Spec::Mocks::Mock.new("a mock")
          mock.should_receive(:message, :message => "recebi nada")
          mock.rspec_verify
        end
        example = @example_group.new(example_definition)
        @reporter.should_receive(:example_finished) do |spec, error|
          error.message.should == "recebi nada"
        end
        example.execute(@options, {})
      end
    end
  end
end
