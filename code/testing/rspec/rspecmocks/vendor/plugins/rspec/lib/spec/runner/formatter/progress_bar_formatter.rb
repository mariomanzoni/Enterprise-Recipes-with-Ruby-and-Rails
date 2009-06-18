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
      class ProgressBarFormatter < BaseTextFormatter
        def example_failed(example, counter, failure)
          @output.print colourise('F', failure)
          @output.flush
        end

        def example_passed(example)
          @output.print green('.')
          @output.flush
        end
      
        def example_pending(example, message)
          super
          @output.print yellow('P')
          @output.flush
        end
        
        def start_dump
          @output.puts
          @output.flush
        end
        
        def method_missing(sym, *args)
          # ignore
        end
      end
    end
  end
end
