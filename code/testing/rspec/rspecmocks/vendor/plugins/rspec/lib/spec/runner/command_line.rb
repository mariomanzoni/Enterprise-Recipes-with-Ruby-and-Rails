#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'spec/runner/option_parser'

module Spec
  module Runner
    class CommandLine
      class << self
        def run(tmp_options=Spec::Runner.options)
          orig_options = Spec::Runner.options
          Spec::Runner.use tmp_options
          tmp_options.run_examples
        ensure
          Spec::Runner.use orig_options
        end
      end
    end
  end
end
