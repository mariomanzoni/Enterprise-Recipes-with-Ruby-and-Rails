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
# Table name: customers
#
#  id         :integer         not null, primary key
#  forename   :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# This is our customer model class.
class Customer < ActiveRecord::Base
end

