#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'
require File.join(File.dirname(__FILE__), *%w[.. .. .. lib autotest rails_rspec])
require File.join(File.dirname(__FILE__), *%w[.. .. .. .. rspec spec autotest_matchers])

describe Autotest::RailsRspec, "file mapping" do
  before(:each) do
    @autotest = Autotest::RailsRspec.new
    @autotest.hook :initialize
  end
  
  it "should map model example to model" do
    @autotest.should map_specs(['spec/models/thing_spec.rb']).
                            to('app/models/thing.rb')
  end
  
  it "should map controller example to controller" do
    @autotest.should map_specs(['spec/controllers/things_controller_spec.rb']).
                            to('app/controllers/things_controller.rb')
  end
  
  it "should map view.rhtml" do
    @autotest.should map_specs(['spec/views/things/index.rhtml_spec.rb']).
                            to('app/views/things/index.rhtml')
  end
  
  it "should map view.rhtml with underscores in example filename" do
    @autotest.should map_specs(['spec/views/things/index_rhtml_spec.rb']).
                            to('app/views/things/index.rhtml')
  end
  
  it "should map view.html.erb" do
    @autotest.should map_specs(['spec/views/things/index.html.erb_spec.rb']).
                            to('app/views/things/index.html.erb')
  end
  
end
