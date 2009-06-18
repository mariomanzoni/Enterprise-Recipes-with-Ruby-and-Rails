#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Mocks
    class ErrorGenerator
      attr_writer :opts
      
      def initialize(target, name)
        @target = target
        @name = name
      end
      
      def opts
        @opts ||= {}
      end

      def raise_unexpected_message_error(sym, *args)
        __raise "#{intro} received unexpected message :#{sym}#{arg_message(*args)}"
      end
      
      def raise_unexpected_message_args_error(expectation, *args)
        expected_args = format_args(*expectation.expected_args)
        actual_args = args.empty? ? "(no args)" : format_args(*args)
        __raise "#{intro} expected #{expectation.sym.inspect} with #{expected_args} but received it with #{actual_args}"
      end
      
      def raise_expectation_error(sym, expected_received_count, actual_received_count, *args)
        __raise "#{intro} expected :#{sym}#{arg_message(*args)} #{count_message(expected_received_count)}, but received it #{count_message(actual_received_count)}"
      end
      
      def raise_out_of_order_error(sym)
        __raise "#{intro} received :#{sym} out of order"
      end
      
      def raise_block_failed_error(sym, detail)
        __raise "#{intro} received :#{sym} but passed block failed with: #{detail}"
      end
      
      def raise_missing_block_error(args_to_yield)
        __raise "#{intro} asked to yield |#{arg_list(*args_to_yield)}| but no block was passed"
      end
      
      def raise_wrong_arity_error(args_to_yield, arity)
        __raise "#{intro} yielded |#{arg_list(*args_to_yield)}| to block with arity of #{arity}"
      end
      
      private
      def intro
        @name ? "Mock '#{@name}'" : @target.inspect
      end
      
      def __raise(message)
        message = opts[:message] unless opts[:message].nil?
        Kernel::raise(Spec::Mocks::MockExpectationError, message)
      end
      
      def arg_message(*args)
        " with " + format_args(*args)
      end
      
      def format_args(*args)
        return "(no args)" if args.empty? || args == [:no_args]
        return "(any args)" if args == [:any_args]
        "(" + arg_list(*args) + ")"
      end

      def arg_list(*args)
        args.collect do |arg|
          arg.respond_to?(:description) ? arg.description : arg.inspect
        end.join(", ")
      end
      
      def count_message(count)
        return "at least #{pretty_print(count.abs)}" if count < 0
        return pretty_print(count)
      end

      def pretty_print(count)
        return "once" if count == 1
        return "twice" if count == 2
        return "#{count} times"
      end

    end
  end
end