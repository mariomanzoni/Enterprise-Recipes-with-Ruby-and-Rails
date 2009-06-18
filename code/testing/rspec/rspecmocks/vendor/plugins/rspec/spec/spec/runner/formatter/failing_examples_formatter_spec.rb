#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../../spec_helper'
require 'spec/runner/formatter/failing_examples_formatter'

module Spec
  module Runner
    module Formatter
      describe FailingExamplesFormatter do
        before(:each) do
          @io = StringIO.new
          options = mock('options')
          @formatter = FailingExamplesFormatter.new(options, @io)
        end

        it "should add example name for each failure" do
          example_group_1 = Class.new(ExampleGroup).describe("A")
          example_group_2 = Class.new(example_group_1).describe("B")

          @formatter.add_example_group(example_group_1)
          @formatter.example_failed(example_group_1.it("a1"){}, nil, Reporter::Failure.new(nil, RuntimeError.new))
          @formatter.add_example_group(example_group_2)
          @formatter.example_failed(example_group_2.it("b2"){}, nil, Reporter::Failure.new(nil, RuntimeError.new))
          @formatter.example_failed(example_group_2.it("b3"){}, nil, Reporter::Failure.new(nil, RuntimeError.new))
          @io.string.should eql(<<-EOF
A a1
A B b2
A B b3
EOF
)
        end
      end
    end
  end
end
