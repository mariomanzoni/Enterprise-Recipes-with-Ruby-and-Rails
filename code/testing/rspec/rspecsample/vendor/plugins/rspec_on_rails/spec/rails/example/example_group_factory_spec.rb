#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

module Spec
  module Example
    describe ExampleGroupFactory do
      it "should return a ModelExampleGroup when given :type => :model" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :type => :model
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ModelExampleGroup
      end

      it "should return a ModelExampleGroup when given :spec_path => '/blah/spec/models/'" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '/blah/spec/models/blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ModelExampleGroup
      end

      it "should return a ModelExampleGroup when given :spec_path => '\\blah\\spec\\models\\' (windows format)" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '\\blah\\spec\\models\\blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ModelExampleGroup
      end

      it "should return a RailsExampleGroup when given :spec_path => '/blah/spec/foo/' (anything other than controllers, views and helpers)" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '/blah/spec/foo/blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::RailsExampleGroup
      end

      it "should return a RailsExampleGroup when given :spec_path => '\\blah\\spec\\foo\\' (windows format)  (anything other than controllers, views and helpers)" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '\\blah\\spec\\foo\\blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::RailsExampleGroup
      end

      it "should return a ViewExampleGroup when given :type => :model" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :type => :view
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ViewExampleGroup
      end

      it "should return a ViewExampleGroup when given :spec_path => '/blah/spec/views/'" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '/blah/spec/views/blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ViewExampleGroup
      end

      it "should return a ModelExampleGroup when given :spec_path => '\\blah\\spec\\views\\' (windows format)" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '\\blah\\spec\\views\\blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ViewExampleGroup
      end

      it "should return a HelperExampleGroup when given :type => :helper" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :type => :helper
        ) {}
        example_group.superclass.should == Spec::Rails::Example::HelperExampleGroup
      end

      it "should return a HelperExampleGroup when given :spec_path => '/blah/spec/helpers/'" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '/blah/spec/helpers/blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::HelperExampleGroup
      end

      it "should return a ModelExampleGroup when given :spec_path => '\\blah\\spec\\helpers\\' (windows format)" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '\\blah\\spec\\helpers\\blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::HelperExampleGroup
      end

      it "should return a ControllerExampleGroup when given :type => :controller" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :type => :controller
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ControllerExampleGroup
      end

      it "should return a ControllerExampleGroup when given :spec_path => '/blah/spec/controllers/'" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '/blah/spec/controllers/blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ControllerExampleGroup
      end

      it "should return a ModelExampleGroup when given :spec_path => '\\blah\\spec\\controllers\\' (windows format)" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '\\blah\\spec\\controllers\\blah.rb'
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ControllerExampleGroup
      end

      it "should favor the :type over the :spec_path" do
        example_group = Spec::Example::ExampleGroupFactory.create_example_group(
          "name", :spec_path => '/blah/spec/models/blah.rb', :type => :controller
        ) {}
        example_group.superclass.should == Spec::Rails::Example::ControllerExampleGroup
      end
    end
  end
end
