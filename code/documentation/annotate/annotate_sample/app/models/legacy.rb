#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# == Schema Information
# Schema version: 2
#
# Table name: foo
#
#  id  :integer         not null, primary key
#  bar :string(255)
#

class Legacy < ActiveRecord::Base
  set_table_name 'foo'
end
