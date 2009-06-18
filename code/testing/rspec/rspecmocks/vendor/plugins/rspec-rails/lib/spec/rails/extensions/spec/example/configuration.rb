#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'spec/example/configuration'
begin
module Spec
  module Example
    class Configuration
      # Rails 1.2.3 does a copy of the @inheritable_attributes to the subclass when the subclass is
      # created. This causes an ordering issue when setting state on Configuration because the data is
      # already copied.
      # Iterating over EXAMPLE_GROUP_CLASSES causes the base ExampleGroup classes to have their
      # @inheritable_attributes updated.
      # TODO: BT - When we no longer support Rails 1.2.3, we can remove this functionality
      EXAMPLE_GROUP_CLASSES = [
        ::Test::Unit::TestCase,
        ::Spec::Rails::Example::RailsExampleGroup,
        ::Spec::Rails::Example::FunctionalExampleGroup,
        ::Spec::Rails::Example::ControllerExampleGroup,
        ::Spec::Rails::Example::ViewExampleGroup,
        ::Spec::Rails::Example::HelperExampleGroup,
        ::Spec::Rails::Example::ModelExampleGroup
      ]
      # All of this is ActiveRecord related and makes no sense if it's not used by the app
      if defined?(ActiveRecord::Base)
        def initialize
          super
          self.fixture_path = RAILS_ROOT + '/spec/fixtures'
        end

        def use_transactional_fixtures
          Test::Unit::TestCase.use_transactional_fixtures
        end
        def use_transactional_fixtures=(value)
          EXAMPLE_GROUP_CLASSES.each do |example_group|
            example_group.use_transactional_fixtures = value
          end
        end

        def use_instantiated_fixtures
          Test::Unit::TestCase.use_instantiated_fixtures
        end
        def use_instantiated_fixtures=(value)
          EXAMPLE_GROUP_CLASSES.each do |example_group|
            example_group.use_instantiated_fixtures = value
          end
        end

        def fixture_path
          Test::Unit::TestCase.fixture_path
        end
        def fixture_path=(path)
          EXAMPLE_GROUP_CLASSES.each do |example_group|
            example_group.fixture_path = path
          end
        end

        def global_fixtures
          ::Test::Unit::TestCase.fixture_table_names
        end
        def global_fixtures=(fixtures)
          EXAMPLE_GROUP_CLASSES.each do |example_group|
            example_group.fixtures(*fixtures)
          end
        end
      end
    end
  end
end
rescue Exception => e
  puts e.message
  puts e.backtrace
  raise e
end