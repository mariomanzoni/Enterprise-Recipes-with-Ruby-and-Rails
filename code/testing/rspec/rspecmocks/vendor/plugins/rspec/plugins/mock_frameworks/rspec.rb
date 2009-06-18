#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "spec", "mocks"))
require 'spec/mocks/framework'
require 'spec/mocks/extensions'

module Spec
  module Plugins
    module MockFramework
      include Spec::Mocks::ExampleMethods
      def setup_mocks_for_rspec
        $rspec_mocks ||= Spec::Mocks::Space.new
      end
      def verify_mocks_for_rspec
        $rspec_mocks.verify_all
      end
      def teardown_mocks_for_rspec
        $rspec_mocks.reset_all
      end
    end
  end
end
