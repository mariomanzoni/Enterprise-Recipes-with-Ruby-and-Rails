#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../../../spec_helper'
require File.dirname(__FILE__) + '/../../../../ruby_forker'

module TestUnitSpecHelper
  include RubyForker
  
  def run_script(file_name)
    output = ruby(file_name)
    if !$?.success? || output.include?("FAILED") || output.include?("Error")
      raise output
    end
    output
  end  
end