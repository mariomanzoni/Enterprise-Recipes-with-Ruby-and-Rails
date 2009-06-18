#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
describe Spec::Adapters::RubyEngine do
  it "should default to MRI" do
    Spec::Adapters::RubyEngine.adapter.should be_an_instance_of(Spec::Adapters::RubyEngine::MRI)
  end
  
  it "should provide Rubinius for rbx" do
    Spec::Adapters::RubyEngine.stub!(:engine).and_return('rbx')
    Spec::Adapters::RubyEngine.adapter.should be_an_instance_of(Spec::Adapters::RubyEngine::Rubinius)
  end
  
  it "should try to find whatever is defined by the RUBY_ENGINE const" do
    Object.stub!(:const_defined?).with('RUBY_ENGINE').and_return(true)
    Object.stub!(:const_get).with('RUBY_ENGINE').and_return("xyz")
    Spec::Adapters::RubyEngine.engine.should == "xyz"
  end
end