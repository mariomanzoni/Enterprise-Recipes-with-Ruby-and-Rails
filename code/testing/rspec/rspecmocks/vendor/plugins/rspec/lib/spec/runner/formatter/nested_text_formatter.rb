#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'spec/runner/formatter/base_text_formatter'

module Spec
  module Runner
    module Formatter
      class NestedTextFormatter < BaseTextFormatter
        attr_reader :previous_nested_example_groups
        def initialize(options, where)
          super
          @previous_nested_example_groups = []
        end

        def add_example_group(example_group)
          super

          current_nested_example_groups = described_example_group_chain
          current_nested_example_groups.each_with_index do |nested_example_group, i|
            unless nested_example_group == previous_nested_example_groups[i]
              output.puts "#{'  ' * i}#{nested_example_group.description_args}"
            end
          end

          @previous_nested_example_groups = described_example_group_chain
        end

        def example_failed(example, counter, failure)
          message = if failure.expectation_not_met?
            "#{current_indentation}#{example.description} (FAILED - #{counter})"
          else
            "#{current_indentation}#{example.description} (ERROR - #{counter})"
          end

          output.puts(failure.expectation_not_met? ? red(message) : magenta(message))
          output.flush
        end

        def example_passed(example)
          message = "#{current_indentation}#{example.description}"
          output.puts green(message)
          output.flush
        end

        def example_pending(example, message)
          super
          output.puts yellow("#{current_indentation}#{example.description} (PENDING: #{message})")
          output.flush
        end

        def current_indentation
          '  ' * previous_nested_example_groups.length
        end

        def described_example_group_chain
          example_group_chain = []
          example_group.send(:execute_in_class_hierarchy) do |parent_example_group|
            if parent_example_group.description_args && !parent_example_group.description_args.empty?
              example_group_chain << parent_example_group
            end
          end
          example_group_chain
        end
      end
    end
  end
end
