#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'test/unit/ui/console/testrunner'

module Test
  module Unit
    module UI
      module Console
        class TestRunner

          alias_method :started_without_rspec, :started
          def started_with_rspec(result)
            @result = result
            @need_to_output_started = true
          end
          alias_method :started, :started_with_rspec

          alias_method :test_started_without_rspec, :test_started
          def test_started_with_rspec(name)
            if @need_to_output_started
              if @rspec_io
                @rspec_io.rewind
                output(@rspec_io.read)
              end
              output("Started")
              @need_to_output_started = false
            end
            test_started_without_rspec(name)
          end
          alias_method :test_started, :test_started_with_rspec

          alias_method :test_finished_without_rspec, :test_finished
          def test_finished_with_rspec(name)
            test_finished_without_rspec(name)
            @ran_test = true
          end
          alias_method :test_finished, :test_finished_with_rspec

          alias_method :finished_without_rspec, :finished
          def finished_with_rspec(elapsed_time)
            @ran_test ||= false
            if @ran_test
              finished_without_rspec(elapsed_time)
            end
          end
          alias_method :finished, :finished_with_rspec
          
          alias_method :setup_mediator_without_rspec, :setup_mediator
          def setup_mediator_with_rspec
            orig_io = @io
            @io = StringIO.new
            setup_mediator_without_rspec
          ensure
            @rspec_io = @io
            @io = orig_io
          end
          alias_method :setup_mediator, :setup_mediator_with_rspec
          
        end
      end
    end
  end
end
