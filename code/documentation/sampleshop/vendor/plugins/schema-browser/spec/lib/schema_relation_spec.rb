#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../spec_helper'

describe SchemaRelation do
  before do
    @rel = SchemaRelation.new(:first, :second, :third, :fourth)
  end

  it "should return first argument of new as origin_table_id" do
    @rel.origin_table_id.should == :first
  end

  it "should return second argument of new as origin_row_id" do
    @rel.origin_row_id.should == :second
  end

  it "should return third argument of new as destination_table_id" do
    @rel.destination_table_id.should == :third
  end

  it "should return fourth argument of new as destination_row_id" do
    @rel.destination_row_id.should == :fourth
  end
end
