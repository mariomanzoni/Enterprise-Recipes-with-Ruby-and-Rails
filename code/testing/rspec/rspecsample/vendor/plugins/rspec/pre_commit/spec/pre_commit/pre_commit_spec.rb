#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../spec_helper.rb'

##
# This is not a complete specification of PreCommit, but 
# just a collection of bug fix regression tests.
describe "The helper method PreCommit#silent_sh" do
  before do
    @pre_commit = PreCommit.new(nil)
  end

  # bug in r1802
  it "should return the command output" do
    @pre_commit.send(:silent_sh, "echo foo").should ==("foo\n")
  end
end
