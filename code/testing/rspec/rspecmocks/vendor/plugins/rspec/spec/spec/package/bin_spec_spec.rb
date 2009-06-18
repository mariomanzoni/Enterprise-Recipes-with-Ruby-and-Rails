#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../ruby_forker'

describe "The bin/spec script" do
  include RubyForker
  
  it "should have no warnings" do
    pending "Hangs on JRuby" if PLATFORM =~ /java/
    spec_path = "#{File.dirname(__FILE__)}/../../../bin/spec"

    output = ruby "-w #{spec_path} --help 2>&1"
    output.should_not =~ /warning/n
  end
end
